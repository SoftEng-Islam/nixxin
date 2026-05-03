#!/usr/bin/env bash

# ─────────────────────────────────────────────
#  showtime — beautiful date & time display
# ─────────────────────────────────────────────

# ── ANSI colours ──────────────────────────────
R="\033[0m"          # reset
BOLD="\033[1m"
DIM="\033[2m"

C_CLOCK="\033[38;5;87m"    # bright cyan  — big clock
C_DATE="\033[38;5;220m"    # gold         — date line
C_SUB="\033[38;5;245m"     # grey         — sub-info
C_SEP="\033[38;5;240m"     # dark grey    — separators
C_LABEL="\033[38;5;141m"   # lavender     — labels
C_VAL="\033[38;5;255m"     # white        — values
C_WARN="\033[38;5;208m"    # orange       — warnings

# ── helpers ──────────────────────────────────
COLS=$(tput cols 2>/dev/null || echo 80)

center() {
    local raw="$1"
    # strip ANSI escapes to measure printable width
    local plain
    plain=$(printf '%b' "$raw" | sed 's/\x1b\[[0-9;]*m//g')
    local len=${#plain}
    local pad=$(( (COLS - len) / 2 ))
    (( pad < 0 )) && pad=0
    printf "%${pad}s" ""
    printf '%b\n' "$raw"
}

hline() {
    local char="${1:-─}"
    local width=$(( COLS > 72 ? 72 : COLS ))
    local pad=$(( (COLS - width) / 2 ))
    printf "%${pad}s" ""
    printf '%b' "${C_SEP}"
    printf '%0.s'"$char" $(seq 1 "$width")
    printf '%b\n' "$R"
}

# ── gather data ──────────────────────────────
NOW=$(date)
TIME_HM=$(date "+%H:%M")        # HH:MM  (for big display)
TIME_S=$(date "+%S")            # seconds (shown small)
DATE_LONG=$(date "+%A, %B %-d %Y")
WEEK=$(date "+%V")              # ISO week number
DOY=$(date "+%j")               # day of year
DOW_NUM=$(date "+%u")           # 1=Mon … 7=Sun
TZ_NAME=$(date "+%Z")
TZ_OFFSET=$(date "+%z")
UNIX_TS=$(date "+%s")
UTC_TIME=$(date -u "+%H:%M %Z")

# Days left in the year
YEAR=$(date "+%Y")
IS_LEAP=$(( ( (YEAR % 4 == 0) && (YEAR % 100 != 0) ) || (YEAR % 400 == 0) ? 1 : 0 ))
DAYS_IN_YEAR=$(( IS_LEAP ? 366 : 365 ))
DAYS_LEFT=$(( DAYS_IN_YEAR - 10#$DOY ))

# Progress bar for day-of-year (width 40)
BAR_WIDTH=40
FILLED=$(( (10#$DOY * BAR_WIDTH) / DAYS_IN_YEAR ))
EMPTY=$(( BAR_WIDTH - FILLED ))
BAR_FILL=$(printf '%0.s█' $(seq 1 "$FILLED") 2>/dev/null)
BAR_EMPTY=$(printf '%0.s░' $(seq 1 "$EMPTY") 2>/dev/null)

# Week progress (Mon=1 … Sun=7)
WEEK_FILL=$(printf '%0.s█' $(seq 1 "$DOW_NUM") 2>/dev/null)
WEEK_EMPTY=$(printf '%0.s░' $(seq 1 $(( 7 - DOW_NUM ))) 2>/dev/null)

# ── render ───────────────────────────────────
echo

# Big ASCII time via toilet
if command -v toilet &>/dev/null; then
    BIG=$(toilet -f future --filter border "$TIME_HM" 2>/dev/null)
    if [[ -n "$BIG" ]]; then
        echo -e "${C_CLOCK}"
        while IFS= read -r line; do
            center "$line"
        done <<< "$BIG"
        echo -e "${R}"
    fi
elif command -v figlet &>/dev/null; then
    BIG=$(figlet -f slant "$TIME_HM" 2>/dev/null)
    if [[ -n "$BIG" ]]; then
        echo -e "${C_CLOCK}"
        while IFS= read -r line; do
            center "$line"
        done <<< "$BIG"
        echo -e "${R}"
    fi
else
    # plain fallback — still pretty
    center "${C_CLOCK}${BOLD}  ⏰  ${TIME_HM}:${TIME_S}  ${R}"
    echo
fi

# Seconds (small, under the big clock)
center "${DIM}${C_SUB}seconds: ${TIME_S}${R}"
echo

hline "─"
echo

# Date
center "${C_DATE}${BOLD}${DATE_LONG}${R}"
echo

# Timezone row
center "${C_LABEL}timezone  ${R}${C_VAL}${TZ_NAME}  ${TZ_OFFSET}${R}   ${C_SEP}│${R}   ${C_LABEL}UTC  ${R}${C_VAL}${UTC_TIME}${R}"
echo

hline "─"
echo

# ── stats grid ───────────────────────────────
# Year progress
center "${C_LABEL}year progress ${R}${C_SUB}(day ${DOY} of ${DAYS_IN_YEAR}, ${DAYS_LEFT} left)${R}"
center "${C_CLOCK}${BAR_FILL}${C_SEP}${BAR_EMPTY}${R}  ${C_SUB}$(( (10#$DOY * 100) / DAYS_IN_YEAR ))%%${R}"
echo

# Week progress
center "${C_LABEL}week progress ${R}${C_SUB}(day ${DOW_NUM} of 7)${R}"
DAYS_LABEL=("Mon" "Tue" "Wed" "Thu" "Fri" "Sat" "Sun")
WEEK_LABELS=""
for i in "${!DAYS_LABEL[@]}"; do
    day_n=$(( i + 1 ))
    if (( day_n < DOW_NUM )); then
        WEEK_LABELS+="${C_CLOCK}${DAYS_LABEL[$i]}${R} "
    elif (( day_n == DOW_NUM )); then
        WEEK_LABELS+="${C_DATE}${BOLD}${DAYS_LABEL[$i]}${R} "
    else
        WEEK_LABELS+="${C_SEP}${DAYS_LABEL[$i]}${R} "
    fi
done
center "$WEEK_LABELS"
echo

hline "─"
echo

# ── info row ────────────────────────────────
center "${C_LABEL}ISO week  ${C_VAL}${WEEK}   ${C_SEP}│   ${C_LABEL}Unix timestamp  ${C_VAL}${UNIX_TS}${R}"
echo