#!/usr/bin/env bash
# Interactive video analyzer with keyboard and mouse sorting.

set -euo pipefail

readonly C_RESET='\033[0m'
readonly C_BOLD='\033[1m'
readonly C_DIM='\033[2m'
readonly C_RED='\033[38;5;196m'
readonly C_GREEN='\033[38;5;46m'
readonly C_YELLOW='\033[38;5;226m'
readonly C_BLUE='\033[38;5;39m'
readonly C_MAGENTA='\033[38;5;201m'
readonly C_CYAN='\033[38;5;51m'
readonly C_WHITE='\033[38;5;231m'
readonly C_GRAY='\033[38;5;245m'
readonly C_DARK_GRAY='\033[38;5;240m'

readonly B_TL="╭"
readonly B_TR="╮"
readonly B_BL="╰"
readonly B_BR="╯"
readonly B_H="─"
readonly B_V="│"
readonly B_TD="┬"
readonly B_TU="┴"
readonly B_TRG="├"
readonly B_TLF="┤"
readonly B_X="┼"

readonly MIN_FILE_NAME_WIDTH=14
readonly HEADER_ROW=5
readonly DATA_ROW_START=7
readonly SORTABLE_FIELDS=(name size duration codec rec dimensions bitrate)

SEARCH_DIR="."
SORT_BY="dimensions"
SORT_DESC=1
OUTPUT_FILE=""

HAS_TTY=0
UI_ACTIVE=0
QUIT_WITHOUT_OUTPUT=0
TTY_STATE=""
CURSOR_POS=0
SCROLL_OFFSET=0
VISIBLE_ROWS=10
TABLE_COLS=120
TABLE_ROWS=24
TERMINAL_TOO_SMALL=0
NEED_RESIZE=1
FORCE_FULL_REDRAW=1
FORCE_CURRENT_ROW_REDRAW=0
LAST_CURSOR_POS=-1
LAST_SCROLL_OFFSET=-1
LAST_SELECTED_TOTAL=-1
LAST_TERMINAL_TOO_SMALL=-1
LAST_STATUS_MESSAGE=""
LAST_STATUS_COLOR=""
STATUS_MESSAGE="Output: selected videos are printed as quoted filenames."
STATUS_COLOR="$C_WHITE"

SORT_TMP=$(mktemp)

declare -a FILES_PATH=()
declare -a FILES_NAME=()
declare -a FILE_SIZES=()
declare -a FILE_SIZE_LABELS=()
declare -a FILE_DURATIONS=()
declare -a FILE_DURATION_LABELS=()
declare -a FILE_CODECS=()
declare -a FILE_RECOMMS=()
declare -a FILE_WIDTHS=()
declare -a FILE_HEIGHTS=()
declare -a FILE_AREA_VALUES=()
declare -a FILE_DIMENSION_LABELS=()
declare -a FILE_BITRATES=()
declare -a FILE_BITRATE_LABELS=()
declare -a ORDER=()
declare -a HEADER_FIELDS=()
declare -a HEADER_WIDTHS=()
declare -a HEADER_STARTS=()
declare -a HEADER_ENDS=()
declare -A SELECTED=()

show_help() {
    cat <<EOF
Video Analyzer - interactive video picker

Usage: $0 [options]

Options:
  -d, --dir <path>     Directory to search (default: current dir)
  -s, --sort <field>   Initial sort: name, size, duration, codec, rec, dimensions, bitrate
  -o, --output <file>  Write the final selected filenames to a file
  -h, --help           Show this help message

Interactive controls:
  Up/Down              Move between videos
  Left/Right           Change the sorted column
  Space                Toggle the current video
  n                    Rename the current video
  1-7                  Sort by table column
  r                    Reverse the current sort
  Enter or q           Finish and print selected videos
  Esc                  Cancel without output

Mouse:
  Click a header to change sort
  Click a row to move the cursor
EOF
}

die() {
    printf '%bError:%b %s\n' "$C_RED" "$C_RESET" "$1" >&2
    exit 1
}

normalize_sort_field() {
    local field="${1,,}"
    case "$field" in
        ""|none|name|file|filename)
            printf 'name'
            ;;
        size)
            printf 'size'
            ;;
        duration|length|time)
            printf 'duration'
            ;;
        codec|type)
            printf 'codec'
            ;;
        rec|recommend|recommendation)
            printf 'rec'
            ;;
        dimensions|dimension|resolution|res)
            printf 'dimensions'
            ;;
        bitrate|bit-rate|rate)
            printf 'bitrate'
            ;;
        *)
            return 1
            ;;
    esac
}

default_sort_desc() {
    case "$1" in
        name|codec)
            printf '0'
            ;;
        *)
            printf '1'
            ;;
    esac
}

sort_label() {
    case "$1" in
        name) printf 'File Name' ;;
        size) printf 'Size' ;;
        duration) printf 'Duration' ;;
        codec) printf 'Codec' ;;
        rec) printf 'Rec.' ;;
        dimensions) printf 'Dimensions' ;;
        bitrate) printf 'Bitrate' ;;
        *) printf '%s' "$1" ;;
    esac
}

sort_arrow() {
    if (( SORT_DESC )); then
        printf ' v'
    else
        printf ' ^'
    fi
}

format_bytes() {
    local bytes="${1:-0}"
    if (( bytes < 1024 )); then
        printf '%d B' "$bytes"
    elif (( bytes < 1048576 )); then
        awk -v value="$bytes" 'BEGIN { printf "%.1f KB", value/1024 }'
    elif (( bytes < 1073741824 )); then
        awk -v value="$bytes" 'BEGIN { printf "%.1f MB", value/1048576 }'
    else
        awk -v value="$bytes" 'BEGIN { printf "%.2f GB", value/1073741824 }'
    fi
}

format_duration() {
    local seconds="${1:-0}"
    if (( seconds < 0 )); then
        seconds=0
    fi

    local hours=$((seconds / 3600))
    local minutes=$(((seconds % 3600) / 60))
    local remaining=$((seconds % 60))
    printf '%02d:%02d:%02d' "$hours" "$minutes" "$remaining"
}

format_dimensions() {
    local width="${1:-0}"
    local height="${2:-0}"
    if (( width > 0 && height > 0 )); then
        printf '%dx%d' "$width" "$height"
    else
        printf 'N/A'
    fi
}

format_bitrate() {
    local bits="${1:-0}"
    if (( bits <= 0 )); then
        printf 'N/A'
    elif (( bits < 1000000 )); then
        awk -v value="$bits" 'BEGIN { printf "%.0f kb/s", value/1000 }'
    else
        awk -v value="$bits" 'BEGIN { printf "%.2f Mb/s", value/1000000 }'
    fi
}

fit_text() {
    local text="$1"
    local width="$2"

    if (( width <= 0 )); then
        return 0
    fi

    if (( ${#text} <= width )); then
        printf '%-*s' "$width" "$text"
        return 0
    fi

    if (( width <= 3 )); then
        printf '%s' "${text:0:width}"
    else
        printf '%-*s' "$width" "${text:0:width-3}..."
    fi
}

repeat_char() {
    local char="$1"
    local count="$2"
    local out=""
    local i

    for ((i = 0; i < count; i++)); do
        out+="$char"
    done

    printf '%s' "$out"
}

quote_output() {
    local value="$1"
    value=${value//\\/\\\\}
    value=${value//\"/\\\"}
    value=${value//$'\t'/\\t}
    value=${value//$'\n'/\\n}
    printf '"%s"' "$value"
}

selected_count() {
    local count=0
    local idx
    for idx in "${!SELECTED[@]}"; do
        if (( SELECTED[$idx] )); then
            ((count += 1))
        fi
    done
    printf '%d' "$count"
}

set_status_message() {
    STATUS_MESSAGE="$1"
    STATUS_COLOR="${2:-$C_WHITE}"
}

draw_border() {
    local left="$1"
    local mid="$2"
    local right="$3"
    shift 3

    local widths=("$@")
    local i

    printf '%b%s' "$C_DARK_GRAY" "$left"
    for i in "${!widths[@]}"; do
        repeat_char "$B_H" $((widths[i] + 2))
        if (( i < ${#widths[@]} - 1 )); then
            printf '%s' "$mid"
        else
            printf '%s%b\n' "$right" "$C_RESET"
        fi
    done
}

print_table_cell() {
    local text="$1"
    local width="$2"
    local color="$3"
    printf ' %b%s%b %b%s%b' "$color" "$(fit_text "$text" "$width")" "$C_RESET" "$C_DARK_GRAY" "$B_V" "$C_RESET"
}

check_dependencies() {
    local cmd
    for cmd in ffprobe jq find sort awk stty mv; do
        command -v "$cmd" >/dev/null 2>&1 || die "$cmd is required but not installed."
    done
}

cleanup_ui() {
    if (( UI_ACTIVE == 0 )); then
        return 0
    fi

    printf '\033[?1000l\033[?1006l\033[?25h\033[?1049l' >&3 2>/dev/null || true
    if [[ -n "$TTY_STATE" ]]; then
        stty "$TTY_STATE" <&4 2>/dev/null || true
    fi
    UI_ACTIVE=0
}

cleanup() {
    local exit_code=$?

    cleanup_ui
    [[ -f "$SORT_TMP" ]] && rm -f "$SORT_TMP"

    if (( HAS_TTY )); then
        exec 3>&- 4<&- 2>/dev/null || true
    fi

    trap - EXIT
    exit "$exit_code"
}

trap cleanup EXIT
trap 'exit 130' INT TERM
trap 'NEED_RESIZE=1' WINCH

build_layout() {
    local dimensions_width=10
    local term_size
    local fixed_width=50
    local name_width

    term_size=$(stty size <&4 2>/dev/null || printf '24 120')
    TABLE_ROWS=${term_size%% *}
    TABLE_COLS=${term_size##* }

    if (( TABLE_ROWS < 14 || TABLE_COLS < 88 )); then
        TERMINAL_TOO_SMALL=1
    else
        TERMINAL_TOO_SMALL=0
    fi

    name_width=$((TABLE_COLS - 25 - fixed_width))
    if (( name_width < MIN_FILE_NAME_WIDTH )); then
        name_width=$MIN_FILE_NAME_WIDTH
    fi

    HEADER_FIELDS=(mark name size duration codec rec dimensions bitrate)
    HEADER_WIDTHS=(2 "$name_width" 9 8 8 4 "$dimensions_width" 9)

    HEADER_STARTS=()
    HEADER_ENDS=()

    local x=1
    local i
    for i in "${!HEADER_FIELDS[@]}"; do
        HEADER_STARTS[i]=$((x + 2))
        HEADER_ENDS[i]=$((HEADER_STARTS[i] + HEADER_WIDTHS[i] - 1))
        x=$((x + HEADER_WIDTHS[i] + 3))
    done

    VISIBLE_ROWS=$((TABLE_ROWS - 9))
    if (( VISIBLE_ROWS < 4 )); then
        VISIBLE_ROWS=4
    fi
}

enable_raw_mode() {
    stty -echo -icanon min 1 time 0 <&4
}

ui_move_to() {
    printf '\033[%d;%dH' "$1" "${2:-1}" >&3
}

scan_videos() {
    local -a candidates=()
    local file

    while IFS= read -r -d '' file; do
        candidates+=("$file")
    done < <(
        find "$SEARCH_DIR" -maxdepth 1 -type f \
            \( -iname '*.mp4' -o -iname '*.mkv' -o -iname '*.avi' -o -iname '*.mov' -o -iname '*.webm' \) \
            -print0 | sort -z
    )

    if (( ${#candidates[@]} == 0 )); then
        printf '%bNo video files found in%b %s\n' "$C_YELLOW" "$C_RESET" "$SEARCH_DIR"
        exit 0
    fi

    local total=${#candidates[@]}
    local index=0
    local ff_out
    local codec
    local duration
    local size
    local width
    local height
    local bitrate
    local area
    local recomm

    for file in "${candidates[@]}"; do
        ((index += 1))
        if (( HAS_TTY )); then
            printf '\r%bScanning%b %d/%d: %s\033[K' "$C_GRAY" "$C_RESET" "$index" "$total" "${file##*/}" >&3
        fi

        ff_out=$(ffprobe -v error \
            -show_entries format=size,duration,bit_rate:stream=codec_type,codec_name,width,height,bit_rate \
            -of json "$file" 2>/dev/null || printf '{}')

        IFS=$'\t' read -r codec duration size width height bitrate < <(
            jq -r '
                ([.streams[]? | select(.codec_type == "video")][0]) as $video
                | [
                    ($video.codec_name // "unknown"),
                    ((.format.duration // 0) | tonumber? // 0 | floor),
                    ((.format.size // 0) | tonumber? // 0 | floor),
                    (($video.width // 0) | tonumber? // 0),
                    (($video.height // 0) | tonumber? // 0),
                    (($video.bit_rate // .format.bit_rate // 0) | tonumber? // 0 | floor)
                  ]
                | @tsv
            ' <<<"$ff_out"
        )

        codec=${codec:-unknown}
        duration=${duration:-0}
        size=${size:-0}
        width=${width:-0}
        height=${height:-0}
        bitrate=${bitrate:-0}
        area=$((width * height))

        recomm="No"
        if [[ "$codec" != "av1" && "$codec" != "unknown" && "$size" -gt 52428800 ]]; then
            recomm="Yes"
        fi

        FILES_PATH+=("$file")
        FILES_NAME+=("${file##*/}")
        FILE_SIZES+=("$size")
        FILE_SIZE_LABELS+=("$(format_bytes "$size")")
        FILE_DURATIONS+=("$duration")
        FILE_DURATION_LABELS+=("$(format_duration "$duration")")
        FILE_CODECS+=("$codec")
        FILE_RECOMMS+=("$recomm")
        FILE_WIDTHS+=("$width")
        FILE_HEIGHTS+=("$height")
        FILE_AREA_VALUES+=("$area")
        FILE_DIMENSION_LABELS+=("$(format_dimensions "$width" "$height")")
        FILE_BITRATES+=("$bitrate")
        FILE_BITRATE_LABELS+=("$(format_bitrate "$bitrate")")
    done

    if (( HAS_TTY )); then
        printf '\r\033[K' >&3
    fi
}

sort_records() {
    : > "$SORT_TMP"

    local i
    local rec_rank
    local -a sort_cmd=(sort -t $'\t' -s)

    case "$SORT_BY" in
        name)
            for i in "${!FILES_NAME[@]}"; do
                printf '%s\t%s\t%d\n' "${FILES_NAME[i],,}" "${FILES_NAME[i]}" "$i" >> "$SORT_TMP"
            done
            sort_cmd+=(-k1,1 -k2,2)
            ;;
        size)
            for i in "${!FILES_NAME[@]}"; do
                printf '%020d\t%s\t%d\n' "${FILE_SIZES[i]}" "${FILES_NAME[i],,}" "$i" >> "$SORT_TMP"
            done
            sort_cmd+=(-k1,1 -k2,2)
            ;;
        duration)
            for i in "${!FILES_NAME[@]}"; do
                printf '%020d\t%s\t%d\n' "${FILE_DURATIONS[i]}" "${FILES_NAME[i],,}" "$i" >> "$SORT_TMP"
            done
            sort_cmd+=(-k1,1 -k2,2)
            ;;
        codec)
            for i in "${!FILES_NAME[@]}"; do
                printf '%s\t%s\t%d\n' "${FILE_CODECS[i],,}" "${FILES_NAME[i],,}" "$i" >> "$SORT_TMP"
            done
            sort_cmd+=(-k1,1 -k2,2)
            ;;
        rec)
            for i in "${!FILES_NAME[@]}"; do
                if [[ "${FILE_RECOMMS[i]}" == 'Yes' ]]; then
                    rec_rank=1
                else
                    rec_rank=0
                fi
                printf '%01d\t%020d\t%s\t%d\n' "$rec_rank" "${FILE_SIZES[i]}" "${FILES_NAME[i],,}" "$i" >> "$SORT_TMP"
            done
            sort_cmd+=(-k1,1 -k2,2 -k3,3)
            ;;
        dimensions)
            for i in "${!FILES_NAME[@]}"; do
                printf '%020d\t%06d\t%06d\t%s\t%d\n' \
                    "${FILE_AREA_VALUES[i]}" "${FILE_WIDTHS[i]}" "${FILE_HEIGHTS[i]}" "${FILES_NAME[i],,}" "$i" >> "$SORT_TMP"
            done
            sort_cmd+=(-k1,1 -k2,2 -k3,3 -k4,4)
            ;;
        bitrate)
            for i in "${!FILES_NAME[@]}"; do
                printf '%020d\t%s\t%d\n' "${FILE_BITRATES[i]}" "${FILES_NAME[i],,}" "$i" >> "$SORT_TMP"
            done
            sort_cmd+=(-k1,1 -k2,2)
            ;;
        *)
            die "Unsupported sort field: $SORT_BY"
            ;;
    esac

    if (( SORT_DESC )); then
        sort_cmd+=(-r)
    fi

    mapfile -t ORDER < <("${sort_cmd[@]}" "$SORT_TMP" | awk -F '\t' '{print $NF}')
}

find_order_position() {
    local target="$1"
    local pos
    for pos in "${!ORDER[@]}"; do
        if [[ "${ORDER[pos]}" == "$target" ]]; then
            printf '%d' "$pos"
            return 0
        fi
    done
    printf '0'
}

ensure_cursor_visible() {
    local max_index=$(( ${#ORDER[@]} - 1 ))
    if (( max_index < 0 )); then
        CURSOR_POS=0
        SCROLL_OFFSET=0
        return 0
    fi

    if (( CURSOR_POS < 0 )); then
        CURSOR_POS=0
    elif (( CURSOR_POS > max_index )); then
        CURSOR_POS=$max_index
    fi

    if (( CURSOR_POS < SCROLL_OFFSET )); then
        SCROLL_OFFSET=$CURSOR_POS
    elif (( CURSOR_POS >= SCROLL_OFFSET + VISIBLE_ROWS )); then
        SCROLL_OFFSET=$((CURSOR_POS - VISIBLE_ROWS + 1))
    fi

    if (( SCROLL_OFFSET < 0 )); then
        SCROLL_OFFSET=0
    fi
}

apply_sort() {
    local current_item="${ORDER[CURSOR_POS]:-0}"
    sort_records
    CURSOR_POS=$(find_order_position "$current_item")
    ensure_cursor_visible
    FORCE_FULL_REDRAW=1
}

set_sort_field() {
    local field="$1"
    if [[ "$field" == "$SORT_BY" ]]; then
        SORT_DESC=$((1 - SORT_DESC))
    else
        SORT_BY="$field"
        SORT_DESC=$(default_sort_desc "$field")
    fi
    apply_sort
}

reverse_sort() {
    SORT_DESC=$((1 - SORT_DESC))
    apply_sort
}

change_sort_column() {
    local offset="$1"
    local i
    for i in "${!SORTABLE_FIELDS[@]}"; do
        if [[ "${SORTABLE_FIELDS[i]}" == "$SORT_BY" ]]; then
            local next=$(((i + offset + ${#SORTABLE_FIELDS[@]}) % ${#SORTABLE_FIELDS[@]}))
            SORT_BY="${SORTABLE_FIELDS[next]}"
            SORT_DESC=$(default_sort_desc "$SORT_BY")
            apply_sort
            return 0
        fi
    done
}

set_cursor_position() {
    local new_pos="$1"
    local previous_scroll="$SCROLL_OFFSET"

    CURSOR_POS="$new_pos"
    ensure_cursor_visible

    if (( SCROLL_OFFSET != previous_scroll )); then
        FORCE_FULL_REDRAW=1
    fi
}

move_cursor() {
    local delta="$1"
    set_cursor_position $((CURSOR_POS + delta))
}

toggle_current_selection() {
    local index="${ORDER[CURSOR_POS]}"
    local current="${SELECTED[$index]:-0}"
    SELECTED["$index"]=$((1 - current))
    FORCE_CURRENT_ROW_REDRAW=1
}

prompt_text() {
    local prompt="$1"
    local prompt_row=$((DATA_ROW_START + VISIBLE_ROWS + 2))
    local input=""

    ui_move_to "$prompt_row"
    printf ' %b%s%b\033[K' "${C_BOLD}${C_YELLOW}" "$prompt" "$C_RESET" >&3
    printf '\033[?25h' >&3

    stty "$TTY_STATE" <&4
    IFS= read -r -u 4 input || true
    enable_raw_mode

    printf '\033[?25l' >&3
    printf '%s' "$input"
}

rename_current_video() {
    local idx="${ORDER[CURSOR_POS]:-}"
    local old_path
    local old_name
    local new_name
    local new_path

    [[ -n "$idx" ]] || return 0

    old_path="${FILES_PATH[idx]}"
    old_name="${FILES_NAME[idx]}"
    new_name=$(prompt_text "Rename ${old_name} to: ")
    FORCE_FULL_REDRAW=1

    new_name="${new_name%$'\r'}"

    if [[ -z "$new_name" ]]; then
        set_status_message "Rename canceled." "$C_GRAY"
        return 0
    fi

    if [[ "$new_name" == "$old_name" ]]; then
        set_status_message "Name unchanged." "$C_GRAY"
        return 0
    fi

    if [[ "$new_name" == */* ]]; then
        set_status_message "Invalid name. Use a filename, not a path." "$C_RED"
        return 0
    fi

    if [[ "$old_path" == */* ]]; then
        new_path="${old_path%/*}/$new_name"
    else
        new_path="$new_name"
    fi

    if [[ -e "$new_path" ]]; then
        set_status_message "Target already exists: $new_name" "$C_RED"
        return 0
    fi

    if mv -- "$old_path" "$new_path"; then
        FILES_PATH[idx]="$new_path"
        FILES_NAME[idx]="$new_name"
        set_status_message "Renamed to $new_name" "$C_GREEN"
        apply_sort
    else
        set_status_message "Rename failed for $old_name" "$C_RED"
    fi
}

setup_ui() {
    TTY_STATE=$(stty -g <&4)
    enable_raw_mode
    printf '\033[?1049h\033[?25l\033[?1000h\033[?1006h' >&3
    UI_ACTIVE=1
}

read_input() {
    local key=""
    local extra=""
    local tail=""
    local ch=""

    IFS= read -rsn1 -u 4 key || return 1

    case "$key" in
        '')
            printf 'enter'
            ;;
        $'\n'|$'\r')
            printf 'enter'
            ;;
        ' ')
            printf 'space'
            ;;
        n|N)
            printf 'rename'
            ;;
        q|Q)
            printf 'finish'
            ;;
        r|R)
            printf 'reverse'
            ;;
        1)
            printf 'sort:name'
            ;;
        2)
            printf 'sort:size'
            ;;
        3)
            printf 'sort:duration'
            ;;
        4)
            printf 'sort:codec'
            ;;
        5)
            printf 'sort:rec'
            ;;
        6)
            printf 'sort:dimensions'
            ;;
        7)
            printf 'sort:bitrate'
            ;;
        $'\e')
            if IFS= read -rsn1 -t 0.01 -u 4 extra; then
                if [[ "$extra" == '[' ]]; then
                    if IFS= read -rsn1 -t 0.01 -u 4 extra; then
                        case "$extra" in
                            A) printf 'up' ;;
                            B) printf 'down' ;;
                            C) printf 'right' ;;
                            D) printf 'left' ;;
                            H) printf 'home' ;;
                            F) printf 'end' ;;
                            5)
                                IFS= read -rsn1 -t 0.01 -u 4 ch || true
                                printf 'pageup'
                                ;;
                            6)
                                IFS= read -rsn1 -t 0.01 -u 4 ch || true
                                printf 'pagedown'
                                ;;
                            '<')
                                while IFS= read -rsn1 -t 0.01 -u 4 ch; do
                                    tail+="$ch"
                                    if [[ "$ch" == 'M' || "$ch" == 'm' ]]; then
                                        break
                                    fi
                                done
                                printf 'mouse:%s' "$tail"
                                ;;
                            *)
                                printf 'escape'
                                ;;
                        esac
                    else
                        printf 'escape'
                    fi
                else
                    printf 'escape'
                fi
            else
                printf 'escape'
            fi
            ;;
        *)
            printf '%s' "$key"
            ;;
    esac
}

handle_header_click() {
    local column="$1"
    local i
    for i in "${!HEADER_FIELDS[@]}"; do
        if (( column >= HEADER_STARTS[i] && column <= HEADER_ENDS[i] )); then
            if [[ "${HEADER_FIELDS[i]}" != 'mark' ]]; then
                set_sort_field "${HEADER_FIELDS[i]}"
            fi
            return 0
        fi
    done
}

handle_mouse_event() {
    local payload="$1"
    local kind="${payload: -1}"
    local body="${payload%?}"
    local button
    local column
    local row
    local target_row

    IFS=';' read -r button column row <<< "$body"

    if [[ "$kind" != 'M' ]]; then
        return 0
    fi

    if (( button == 64 )); then
        move_cursor -3
        return 0
    fi

    if (( button == 65 )); then
        move_cursor 3
        return 0
    fi

    if (( (button & 3) != 0 )); then
        return 0
    fi

    if (( row == HEADER_ROW )); then
        handle_header_click "$column"
        return 0
    fi

    if (( row >= DATA_ROW_START && row < DATA_ROW_START + VISIBLE_ROWS )); then
        target_row=$((SCROLL_OFFSET + row - DATA_ROW_START))
        if (( target_row >= 0 && target_row < ${#ORDER[@]} )); then
            set_cursor_position "$target_row"
        fi
    fi
}

draw_title_line() {
    ui_move_to 1
    printf ' %bVIDEO ANALYZER%b\033[K' "${C_BOLD}${C_CYAN}" "$C_RESET" >&3
}

draw_info_line() {
    local selected_total="$1"
    local dir_width=$((TABLE_COLS - 46))

    if (( dir_width < 10 )); then
        dir_width=10
    fi

    ui_move_to 2
    printf ' %bDir:%b %s  %bFiles:%b %d  %bSelected:%b %s  %bSort:%b %s%s\033[K' \
        "$C_BOLD" "$C_RESET" "$(fit_text "$SEARCH_DIR" "$dir_width")" \
        "$C_BOLD" "$C_RESET" "${#ORDER[@]}" \
        "$C_BOLD" "$C_RESET" "$selected_total" \
        "$C_BOLD" "$C_RESET" "$(sort_label "$SORT_BY")" "$(sort_arrow)" >&3
}

draw_controls_line() {
    ui_move_to 3
    printf ' %bArrows%b move  %bSpace%b select  %bn%b rename  %b1-7%b sort  %br%b reverse  %bEnter/q%b finish  %bEsc%b cancel\033[K' \
        "$C_BOLD" "$C_RESET" "$C_BOLD" "$C_RESET" "$C_BOLD" "$C_RESET" \
        "$C_BOLD" "$C_RESET" "$C_BOLD" "$C_RESET" "$C_BOLD" "$C_RESET" >&3
}

draw_header_line() {
    local i
    local field
    local label
    local color

    ui_move_to 4
    draw_border "$B_TL" "$B_TD" "$B_TR" "${HEADER_WIDTHS[@]}" >&3

    ui_move_to "$HEADER_ROW"
    printf '%b%s%b' "$C_DARK_GRAY" "$B_V" "$C_RESET" >&3
    for i in "${!HEADER_FIELDS[@]}"; do
        field="${HEADER_FIELDS[i]}"
        case "$field" in
            mark) label='Mk' ;;
            name) label='File Name' ;;
            size) label='Size' ;;
            duration) label='Duration' ;;
            codec) label='Codec' ;;
            rec) label='Rec.' ;;
            dimensions) label='Dimensions' ;;
            bitrate) label='Bitrate' ;;
        esac

        if [[ "$field" == "$SORT_BY" ]]; then
            color="${C_BOLD}${C_YELLOW}"
            label+=$(sort_arrow)
        else
            color="${C_BOLD}${C_WHITE}"
        fi

        print_table_cell "$label" "${HEADER_WIDTHS[i]}" "$color" >&3
    done
    printf '\033[K' >&3

    ui_move_to 6
    draw_border "$B_TRG" "$B_X" "$B_TLF" "${HEADER_WIDTHS[@]}" >&3
}

draw_data_row() {
    local row="$1"
    local screen_row=$((DATA_ROW_START + row))
    local order_pos=$((SCROLL_OFFSET + row))
    local idx
    local marker
    local marker_color
    local name_color
    local codec_color
    local rec_color
    local dim_color
    local bit_color
    local i

    ui_move_to "$screen_row"
    printf '%b%s%b' "$C_DARK_GRAY" "$B_V" "$C_RESET" >&3

    if (( order_pos < ${#ORDER[@]} )); then
        idx=${ORDER[order_pos]}
        marker=' '
        if (( order_pos == CURSOR_POS )) && [[ "${SELECTED[$idx]:-0}" == '1' ]]; then
            marker='>*'
        elif (( order_pos == CURSOR_POS )); then
            marker='>'
        elif [[ "${SELECTED[$idx]:-0}" == '1' ]]; then
            marker='*'
        fi

        if (( order_pos == CURSOR_POS )); then
            marker_color="${C_BOLD}${C_YELLOW}"
            name_color="${C_BOLD}${C_CYAN}"
        else
            marker_color="${C_GRAY}"
            name_color="${C_CYAN}"
        fi

        case "${FILE_CODECS[idx]}" in
            h264) codec_color="${C_YELLOW}" ;;
            hevc) codec_color="${C_BLUE}" ;;
            av1) codec_color="${C_MAGENTA}" ;;
            *) codec_color="${C_WHITE}" ;;
        esac

        if [[ "${FILE_RECOMMS[idx]}" == 'Yes' ]]; then
            rec_color="${C_BOLD}${C_RED}"
        else
            rec_color="${C_DIM}${C_GRAY}"
        fi

        dim_color="${C_MAGENTA}"
        bit_color="${C_GREEN}"

        print_table_cell "$marker" "${HEADER_WIDTHS[0]}" "$marker_color" >&3
        print_table_cell "${FILES_NAME[idx]}" "${HEADER_WIDTHS[1]}" "$name_color" >&3
        print_table_cell "${FILE_SIZE_LABELS[idx]}" "${HEADER_WIDTHS[2]}" "$C_GREEN" >&3
        print_table_cell "${FILE_DURATION_LABELS[idx]}" "${HEADER_WIDTHS[3]}" "$C_WHITE" >&3
        print_table_cell "${FILE_CODECS[idx]}" "${HEADER_WIDTHS[4]}" "$codec_color" >&3
        print_table_cell "${FILE_RECOMMS[idx]}" "${HEADER_WIDTHS[5]}" "$rec_color" >&3
        print_table_cell "${FILE_DIMENSION_LABELS[idx]}" "${HEADER_WIDTHS[6]}" "$dim_color" >&3
        print_table_cell "${FILE_BITRATE_LABELS[idx]}" "${HEADER_WIDTHS[7]}" "$bit_color" >&3
    else
        for i in "${!HEADER_WIDTHS[@]}"; do
            print_table_cell '' "${HEADER_WIDTHS[i]}" "$C_WHITE" >&3
        done
    fi

    printf '\033[K' >&3
}

draw_footer_line() {
    local footer_row=$((DATA_ROW_START + VISIBLE_ROWS + 1))
    local total_pages=$(( (${#ORDER[@]} + VISIBLE_ROWS - 1) / VISIBLE_ROWS ))
    local current_page=$(( CURSOR_POS / VISIBLE_ROWS + 1 ))

    if (( total_pages == 0 )); then
        total_pages=1
        current_page=1
    fi

    ui_move_to "$footer_row"
    printf ' %bPage:%b %d/%d  %bCurrent:%b %d/%d  %bMouse:%b click headers to sort\033[K' \
        "$C_BOLD" "$C_RESET" "$current_page" "$total_pages" \
        "$C_BOLD" "$C_RESET" "$((CURSOR_POS + 1))" "${#ORDER[@]}" \
        "$C_BOLD" "$C_RESET" >&3
}

draw_status_line() {
    local status_row=$((DATA_ROW_START + VISIBLE_ROWS + 2))
    local message_width=$((TABLE_COLS - 10))

    if (( message_width < 10 )); then
        message_width=10
    fi

    ui_move_to "$status_row"
    printf ' %bStatus:%b %b%s%b\033[K' \
        "$C_BOLD" "$C_RESET" "$STATUS_COLOR" "$(fit_text "$STATUS_MESSAGE" "$message_width")" "$C_RESET" >&3
}

draw_bottom_border() {
    ui_move_to "$((DATA_ROW_START + VISIBLE_ROWS))"
    draw_border "$B_BL" "$B_TU" "$B_BR" "${HEADER_WIDTHS[@]}" >&3
}

render_ui() {
    local selected_total
    local row

    if (( NEED_RESIZE )); then
        build_layout
        ensure_cursor_visible
        NEED_RESIZE=0
        FORCE_FULL_REDRAW=1
        printf '\033[2J' >&3
    fi

    selected_total=$(selected_count)

    if (( TERMINAL_TOO_SMALL )); then
        if (( FORCE_FULL_REDRAW || LAST_TERMINAL_TOO_SMALL != TERMINAL_TOO_SMALL )); then
            printf '\033[2J' >&3
            ui_move_to 1
            printf ' %bVIDEO ANALYZER%b\033[K' "${C_BOLD}${C_CYAN}" "$C_RESET" >&3
            ui_move_to 2
            printf ' %bTerminal too small.%b Need at least 88x14, have %dx%d.\033[K' "$C_YELLOW" "$C_RESET" "$TABLE_COLS" "$TABLE_ROWS" >&3
            ui_move_to 3
            printf ' Resize the window, then keep using the same session.\033[K' >&3
            ui_move_to 4
            printf ' %bEnter/q%b finish  %bEsc%b cancel\033[K' "$C_BOLD" "$C_RESET" "$C_BOLD" "$C_RESET" >&3
        fi

        LAST_TERMINAL_TOO_SMALL=$TERMINAL_TOO_SMALL
        LAST_SELECTED_TOTAL=$selected_total
        LAST_CURSOR_POS=$CURSOR_POS
        LAST_SCROLL_OFFSET=$SCROLL_OFFSET
        LAST_STATUS_MESSAGE="$STATUS_MESSAGE"
        LAST_STATUS_COLOR="$STATUS_COLOR"
        FORCE_FULL_REDRAW=0
        FORCE_CURRENT_ROW_REDRAW=0
        return 0
    fi

    if (( LAST_SCROLL_OFFSET != SCROLL_OFFSET )); then
        FORCE_FULL_REDRAW=1
    fi

    if (( FORCE_FULL_REDRAW || LAST_TERMINAL_TOO_SMALL != TERMINAL_TOO_SMALL )); then
        if (( LAST_TERMINAL_TOO_SMALL != TERMINAL_TOO_SMALL )); then
            printf '\033[2J' >&3
        fi
        draw_title_line
        draw_info_line "$selected_total"
        draw_controls_line
        draw_header_line
        for ((row = 0; row < VISIBLE_ROWS; row++)); do
            draw_data_row "$row"
        done
        draw_bottom_border
        draw_footer_line
        draw_status_line
    else
        if (( LAST_SELECTED_TOTAL != selected_total )); then
            draw_info_line "$selected_total"
        fi

        if (( LAST_CURSOR_POS != CURSOR_POS )); then
            if (( LAST_CURSOR_POS >= SCROLL_OFFSET && LAST_CURSOR_POS < SCROLL_OFFSET + VISIBLE_ROWS )); then
                draw_data_row "$((LAST_CURSOR_POS - SCROLL_OFFSET))"
            fi
            if (( CURSOR_POS >= SCROLL_OFFSET && CURSOR_POS < SCROLL_OFFSET + VISIBLE_ROWS )); then
                draw_data_row "$((CURSOR_POS - SCROLL_OFFSET))"
            fi
            draw_footer_line
        elif (( FORCE_CURRENT_ROW_REDRAW )); then
            if (( CURSOR_POS >= SCROLL_OFFSET && CURSOR_POS < SCROLL_OFFSET + VISIBLE_ROWS )); then
                draw_data_row "$((CURSOR_POS - SCROLL_OFFSET))"
            fi
        fi

        if [[ "$STATUS_MESSAGE" != "$LAST_STATUS_MESSAGE" || "$STATUS_COLOR" != "$LAST_STATUS_COLOR" ]]; then
            draw_status_line
        fi
    fi

    LAST_TERMINAL_TOO_SMALL=$TERMINAL_TOO_SMALL
    LAST_SELECTED_TOTAL=$selected_total
    LAST_CURSOR_POS=$CURSOR_POS
    LAST_SCROLL_OFFSET=$SCROLL_OFFSET
    LAST_STATUS_MESSAGE="$STATUS_MESSAGE"
    LAST_STATUS_COLOR="$STATUS_COLOR"
    FORCE_FULL_REDRAW=0
    FORCE_CURRENT_ROW_REDRAW=0
}

render_plain_table() {
    local idx
    printf '%-34s %-9s %-8s %-8s %-4s %-10s %-9s\n' 'File Name' 'Size' 'Duration' 'Codec' 'Rec.' 'Dimensions' 'Bitrate'
    for idx in "${ORDER[@]}"; do
        printf '%-34s %-9s %-8s %-8s %-4s %-10s %-9s\n' \
            "$(fit_text "${FILES_NAME[idx]}" 34)" \
            "${FILE_SIZE_LABELS[idx]}" \
            "${FILE_DURATION_LABELS[idx]}" \
            "${FILE_CODECS[idx]}" \
            "${FILE_RECOMMS[idx]}" \
            "${FILE_DIMENSION_LABELS[idx]}" \
            "${FILE_BITRATE_LABELS[idx]}"
    done
}

write_sorted_output_file() {
    local idx
    : > "$OUTPUT_FILE"
    for idx in "${ORDER[@]}"; do
        quote_output "${FILES_NAME[idx]}" >> "$OUTPUT_FILE"
        printf '\n' >> "$OUTPUT_FILE"
    done
}

write_selected_output() {
    local idx
    local line

    if [[ -n "$OUTPUT_FILE" ]]; then
        : > "$OUTPUT_FILE"
    fi

    for idx in "${ORDER[@]}"; do
        if [[ "${SELECTED[$idx]:-0}" == '1' ]]; then
            line=$(quote_output "${FILES_NAME[idx]}")
            printf '%s\n' "$line"
            if [[ -n "$OUTPUT_FILE" ]]; then
                printf '%s\n' "$line" >> "$OUTPUT_FILE"
            fi
        fi
    done
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        -d|--dir)
            [[ $# -ge 2 ]] || die "Missing value for $1"
            SEARCH_DIR="$2"
            shift 2
            ;;
        -s|--sort)
            [[ $# -ge 2 ]] || die "Missing value for $1"
            SORT_BY="$2"
            shift 2
            ;;
        -o|--output)
            [[ $# -ge 2 ]] || die "Missing value for $1"
            OUTPUT_FILE="$2"
            shift 2
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            die "Unknown option: $1"
            ;;
    esac
done

[[ -d "$SEARCH_DIR" ]] || die "Directory not found: $SEARCH_DIR"

check_dependencies

SORT_BY=$(normalize_sort_field "$SORT_BY") || die "Unsupported sort field: $SORT_BY"
SORT_DESC=$(default_sort_desc "$SORT_BY")

if exec 3>/dev/tty 4</dev/tty; then
    HAS_TTY=1
fi

scan_videos
sort_records

if (( HAS_TTY )); then
    setup_ui

    local_action=''
    while true; do
        render_ui
        local_action=$(read_input)
        case "$local_action" in
            up)
                move_cursor -1
                ;;
            down)
                move_cursor 1
                ;;
            pageup)
                move_cursor "-$VISIBLE_ROWS"
                ;;
            pagedown)
                move_cursor "$VISIBLE_ROWS"
                ;;
            home)
                set_cursor_position 0
                ;;
            end)
                set_cursor_position $(( ${#ORDER[@]} - 1 ))
                ;;
            left)
                change_sort_column -1
                ;;
            right)
                change_sort_column 1
                ;;
            space)
                toggle_current_selection
                ;;
            rename)
                rename_current_video
                ;;
            reverse)
                reverse_sort
                ;;
            sort:*)
                set_sort_field "${local_action#sort:}"
                ;;
            mouse:*)
                handle_mouse_event "${local_action#mouse:}"
                ;;
            enter|finish)
                break
                ;;
            escape)
                QUIT_WITHOUT_OUTPUT=1
                break
                ;;
        esac
    done

    cleanup_ui

    if (( QUIT_WITHOUT_OUTPUT == 0 )); then
        write_selected_output
    fi
else
    render_plain_table
    if [[ -n "$OUTPUT_FILE" ]]; then
        write_sorted_output_file
    fi
fi
