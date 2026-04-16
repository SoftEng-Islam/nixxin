#!/usr/bin/env bash
# Video Analyzer Script
# A beautiful, btop-inspired script to analyze and sort video files using ffprobe.

set -euo pipefail

# --- Configuration & Colors ---
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
readonly C_GRAY='\033[38;5;242m'
readonly C_DARK_GRAY='\033[38;5;236m'
readonly BG_TITLE='\033[48;5;238m'

# Box drawing
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

# Defaults
SEARCH_DIR="."
SORT_BY="none"
OUTPUT_FILE=""

show_help() {
    echo -e "${C_BOLD}${C_CYAN}Video Analyzer - Smart Media Info CLI${C_RESET}"
    echo -e "Usage: $0 [options]"
    echo ""
    echo -e "Options:"
    echo -e "  -d, --dir <path>     Directory to search for video files (default: current dir)"
    echo -e "  -s, --sort <field>   Sort by: ${C_YELLOW}size${C_RESET}, ${C_YELLOW}length${C_RESET}, ${C_YELLOW}type${C_RESET}"
    echo -e "  -o, --output <file>  Save beautiful output to a text file"
    echo -e "  -h, --help           Show this help message"
    echo ""
}

# --- Argument Parsing ---
while [[ $# -gt 0 ]]; do
    case "$1" in
        -d|--dir)
            SEARCH_DIR="$2"
            shift 2
            ;;
        -s|--sort)
            SORT_BY="$2"
            shift 2
            ;;
        -o|--output)
            OUTPUT_FILE="$2"
            shift 2
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            echo -e "${C_RED}Unknown option: $1${C_RESET}"
            show_help
            exit 1
            ;;
    esac
done

if ! command -v ffprobe &> /dev/null; then
    echo -e "${C_RED}Error: ffprobe (ffmpeg) is required but not installed.${C_RESET}"
    exit 1
fi

# --- Helper Functions ---
format_bytes() {
    local -i bytes=$1
    if [[ $bytes -lt 1024 ]]; then
        echo "${bytes} B"
    elif [[ $bytes -lt 1048576 ]]; then
        awk "BEGIN { printf \"%.1f KB\", $bytes/1024 }"
    elif [[ $bytes -lt 1073741824 ]]; then
        awk "BEGIN { printf \"%.1f MB\", $bytes/1048576 }"
    else
        awk "BEGIN { printf \"%.2f GB\", $bytes/1073741824 }"
    fi
}

format_duration() {
    local seconds=$(printf "%.0f" "$1" 2>/dev/null || echo 0)
    local h=$((seconds / 3660))
    local m=$(( (seconds % 3600) / 60 ))
    local s=$((seconds % 60))
    printf "%02d:%02d:%02d" $h $m $s
}

strip_ansi() {
    sed 's/\x1b\[[0-9;]*m//g'
}

# Arrays to store data
declare -a FILES
declare -a SIZES
declare -a DURATIONS
declare -a CODECS
declare -a RECOMMS

echo -e "${C_GRAY}Scanning for videos in ${C_BOLD}${SEARCH_DIR}${C_RESET}..."

# Create a temporary file to store intermediate lines before sorting
TMP_DATA=$(mktemp)
trap 'rm -f "$TMP_DATA"' EXIT

# Find common video files
find "$SEARCH_DIR" -maxdepth 1 -type f \
    \( -iname "*.mp4" -o -iname "*.mkv" -o -iname "*.avi" -o -iname "*.mov" -o -iname "*.webm" \) | while read -r file; do
    
    # Run ffprobe
    # Extract duration, size, format name, video codec.
    ff_out=$(ffprobe -v error -select_streams v:0 \
        -show_entries format=size,duration:stream=codec_name \
        -of json "$file" 2>/dev/null || echo "{}")
    
    if [[ -n "$ff_out" && "$ff_out" != "{}" ]]; then
        codec=$(echo "$ff_out" | jq -r '.streams[0].codec_name // "unknown"' | head -n1)
        duration=$(echo "$ff_out" | jq -r '.format.duration // "0"' | head -n1)
        size=$(echo "$ff_out" | jq -r '.format.size // "0"' | head -n1)
        
        # Clean up non-numeric characters to prevent bash syntax errors
        size="${size//[^0-9]/}"
        duration="${duration//[^0-9.]/}"
        
        # Fallbacks
        [[ -z "$duration" || "$duration" == "null" || "$duration" == "N/A" ]] && duration="0"
        [[ -z "$size" || "$size" == "null" || "$size" == "N/A" ]] && size="0"
        [[ -z "$codec" || "$codec" == "null" ]] && codec="unknown"

        # Logic for AV1 recommendation
        # If it's av1, vp9, or hevc, maybe it's already good.
        # But let's recommend AV1 for everything except AV1 itselt to save maximum space if the size is large enough.
        # E.g. if size > 50MB and codec != av1
        recomm="No"
        if [[ "$codec" != "av1" && "$codec" != "unknown" ]]; then
            if [[ "$size" -gt 52428800 ]]; then # > 50MB
                recomm="Yes"
            fi
        fi

        basename=$(basename "$file")
        printf "%s\t%s\t%s\t%s\t%s\n" "$basename" "$size" "$duration" "$codec" "$recomm" >> "$TMP_DATA"
    fi
done

total_files=$(wc -l < "$TMP_DATA")
if [[ $total_files -eq 0 ]]; then
    echo -e "${C_YELLOW}No video files found.${C_RESET}"
    exit 0
fi

# --- Sorting ---
# Data columns: 1=Name, 2=Size, 3=Duration, 4=Codec, 5=Recomm
SORTED_DATA=$(mktemp)
trap 'rm -f "$TMP_DATA" "$SORTED_DATA"' EXIT

case "$SORT_BY" in
    size)   sort -t$'\t' -k2,2nr "$TMP_DATA" > "$SORTED_DATA" ;;
    length) sort -t$'\t' -k3,3nr "$TMP_DATA" > "$SORTED_DATA" ;;
    type)   sort -t$'\t' -k4,4   "$TMP_DATA" > "$SORTED_DATA" ;;
    *)      cp "$TMP_DATA" "$SORTED_DATA" ;;
esac

# --- Rendering the UI ---
UI_OUT=$(mktemp)
trap 'rm -f "$TMP_DATA" "$SORTED_DATA" "$UI_OUT"' EXIT

draw_horizontal_line() {
    local left=$1
    local mid=$2
    local right=$3
    printf "${C_DARK_GRAY}%s" "$left"
    for _ in {1..35}; do printf "%s" "$B_H"; done; printf "%s" "$mid" # Filename
    for _ in {1..12}; do printf "%s" "$B_H"; done; printf "%s" "$mid" # Size
    for _ in {1..12}; do printf "%s" "$B_H"; done; printf "%s" "$mid" # Duration
    for _ in {1..10}; do printf "%s" "$B_H"; done; printf "%s" "$mid" # Codec
    for _ in {1..12}; do printf "%s" "$B_H"; done; printf "%s${C_RESET}\n" "$right" # Recomm
}

{
    echo -e ""
    echo -e " ${C_BOLD}${C_BLUE}❖ VIDEO ANALYZER ❖${C_RESET}   ${C_DIM}Tot. Files: ${total_files}${C_RESET}   ${C_DIM}Sort: ${SORT_BY}${C_RESET}"
    echo -e ""
    draw_horizontal_line "$B_TL" "$B_TD" "$B_TR"
    
    # Header
    printf "${C_DARK_GRAY}${B_V} ${C_BOLD}${C_WHITE}%-34s ${C_DARK_GRAY}${B_V} ${C_BOLD}${C_WHITE}%-11s ${C_DARK_GRAY}${B_V} ${C_BOLD}${C_WHITE}%-11s ${C_DARK_GRAY}${B_V} ${C_BOLD}${C_WHITE}%-9s ${C_DARK_GRAY}${B_V} ${C_BOLD}${C_WHITE}%-11s ${C_DARK_GRAY}${B_V}${C_RESET}\n" \
        "Filename" "Size" "Duration" "Codec" "Rec. AV1?"
    
    draw_horizontal_line "$B_TRG" "$B_X" "$B_TLF"

    while IFS=$'\t' read -r name size dur codec rec; do
        # Truncate name
        if [[ ${#name} -gt 33 ]]; then
            display_name="${name:0:30}..."
        else
            display_name="$name"
        fi

        # Formats
        disp_size=$(format_bytes "$size")
        disp_dur=$(format_duration "$dur")
        
        # Coloring
        c_name="${C_CYAN}"
        c_size="${C_GREEN}"
        
        if [[ "$codec" == "h264" ]]; then c_cod="${C_YELLOW}"
        elif [[ "$codec" == "hevc" ]]; then c_cod="${C_BLUE}"
        elif [[ "$codec" == "av1" ]]; then c_cod="${C_MAGENTA}"
        else c_cod="${C_WHITE}"; fi

        if [[ "$rec" == "Yes" ]]; then c_rec="${C_BOLD}${C_RED}"
        else c_rec="${C_DIM}${C_GRAY}"; fi

        printf "${C_DARK_GRAY}${B_V} ${c_name}%-34s ${C_DARK_GRAY}${B_V} ${c_size}%-11s ${C_DARK_GRAY}${B_V} ${C_WHITE}%-11s ${C_DARK_GRAY}${B_V} ${c_cod}%-9s ${C_DARK_GRAY}${B_V} ${c_rec}%-11s ${C_DARK_GRAY}${B_V}${C_RESET}\n" \
            "$display_name" "$disp_size" "$disp_dur" "$codec" "$rec"

    done < "$SORTED_DATA"

    draw_horizontal_line "$B_BL" "$B_TU" "$B_BR"
    echo ""
} > "$UI_OUT"

# Output display
cat "$UI_OUT"

if [[ -n "$OUTPUT_FILE" ]]; then
    # Strip ansi codes and export
    strip_ansi < "$UI_OUT" > "$OUTPUT_FILE"
    echo -e "${C_GREEN}✔ Output successfully saved to ${C_BOLD}$OUTPUT_FILE${C_RESET}"
fi
