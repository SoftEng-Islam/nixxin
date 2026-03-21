#!/usr/bin/env bash

# ============================================================
# AV1 Batch Video Encoder
# Encodes a list of videos to AV1 (libsvtav1) with audio copy
# ============================================================

# --- Configuration ---
CODEC="libsvtav1"
PRESET="8"          # 0-13 (lower = better compression/slower. 8-10 is a good balance for speed)
CRF="30"            # Constant Rate Factor (lower = better quality. 24-30 is typical for AV1)
AUDIO_CODEC="copy"
OUTPUT_EXT="mkv"
LOG_FILE="status.txt"

# --- Define your video list here ---
# Add or remove entries as needed. Each entry is the input filename.
VIDEOS=(
  "input1.mp4"
  # "input2.mkv"
)

# --- Helper functions ---

# Log to stdout and to the log file
log() {
  echo "$*"
  echo "$*" >> "$LOG_FILE"
}

# Log a blank line to stdout and to the log file
log_blank() {
  echo ""
  echo "" >> "$LOG_FILE"
}

# Print a separator line
separator() {
  log "============================================================"
}

# Get video duration via ffprobe
get_duration() {
  ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$1" 2>/dev/null
}

# Format seconds to HH:MM:SS
format_time() {
  local total_seconds="${1%.*}" # strip decimals
  if [[ -z "$total_seconds" || "$total_seconds" == "N/A" ]]; then
    echo "Unknown"
    return
  fi
  local hours=$((total_seconds / 3600))
  local minutes=$(( (total_seconds % 3600) / 60 ))
  local seconds=$((total_seconds % 60))
  printf "%02d:%02d:%02d" "$hours" "$minutes" "$seconds"
}

# Print video info (resolution, codec, duration, file size)
print_video_info() {
  local file="$1"
  log "  File     : $file"

  # Duration
  local dur
  dur=$(get_duration "$file")
  log "  Duration : $(format_time "$dur")"

  # Video stream info
  local vinfo
  vinfo=$(ffprobe -v error -select_streams v:0 \
    -show_entries stream=codec_name,width,height,bit_rate,r_frame_rate \
    -of default=noprint_wrappers=1 "$file" 2>/dev/null)

  local vcodec width height fps bitrate
  vcodec=$(echo "$vinfo" | grep "^codec_name=" | cut -d= -f2)
  width=$(echo "$vinfo"  | grep "^width="      | cut -d= -f2)
  height=$(echo "$vinfo" | grep "^height="     | cut -d= -f2)
  fps=$(echo "$vinfo"    | grep "^r_frame_rate="| cut -d= -f2)
  bitrate=$(echo "$vinfo"| grep "^bit_rate="   | cut -d= -f2)

  log "  Video    : ${vcodec:-N/A}, ${width:-?}x${height:-?}, ${fps:-N/A} fps, bitrate ${bitrate:-N/A}"

  # Audio stream info
  local ainfo
  ainfo=$(ffprobe -v error -select_streams a:0 \
    -show_entries stream=codec_name,sample_rate,channels \
    -of default=noprint_wrappers=1 "$file" 2>/dev/null)

  local acodec sample_rate channels
  acodec=$(echo "$ainfo"      | grep "^codec_name="  | cut -d= -f2)
  sample_rate=$(echo "$ainfo" | grep "^sample_rate="  | cut -d= -f2)
  channels=$(echo "$ainfo"    | grep "^channels="     | cut -d= -f2)

  log "  Audio    : ${acodec:-N/A}, ${sample_rate:-N/A} Hz, ${channels:-N/A} ch"

  # File size
  local size
  size=$(du -h "$file" 2>/dev/null | cut -f1)
  log "  Size     : ${size:-N/A}"
}

# --- Main ---

total=${#VIDEOS[@]}

log_blank
separator
log "  AV1 Batch Encoder — $total video(s) queued"
separator
log_blank

success=0
fail=0
skipped=0

for i in "${!VIDEOS[@]}"; do
  input="${VIDEOS[$i]}"
  num=$((i + 1))

  # Build output filename: strip extension, append OUTPUT_EXT
  base="${input%.*}"
  output="${base}.${OUTPUT_EXT}"

  # If input already has the target extension, add a suffix to avoid overwriting
  if [[ "$input" == "$output" ]]; then
    output="${base}.av1.${OUTPUT_EXT}"
  fi

  separator
  log "[$num/$total] Encoding: $input"
  separator

  # Check if input file exists
  if [[ ! -f "$input" ]]; then
    log "[SKIP] File not found: $input"
    log_blank
    ((skipped++))
    continue
  fi

  # Print info about the source video
  print_video_info "$input"
  log_blank

  # Record start time
  start_time=$(date +%s)

  # Encode
  # -hwaccel auto: Offloads input video decoding to GPU (e.g., Radeon via VAAPI)
  # -preset $PRESET & -crf $CRF: Defines SVT-AV1 performance and quality metrics
  SVT_LOG="${SVT_LOG:-0}" ffmpeg -hide_banner -loglevel warning -stats -hwaccel auto -y -i "$input" -c:v "$CODEC" -preset "$PRESET" -crf "$CRF" -c:a "$AUDIO_CODEC" "$output"

  exit_code=$?
  end_time=$(date +%s)
  elapsed=$((end_time - start_time))

  if [[ $exit_code -eq 0 ]]; then
    out_size=$(du -h "$output" 2>/dev/null | cut -f1)
    log_blank
    log "[DONE!] $output  (size: ${out_size:-N/A}, took: $(format_time $elapsed))"
    ((success++))
  else
    log_blank
    log "[FAILED!] $input  (exit code: $exit_code, after: $(format_time $elapsed))"
    ((fail++))
  fi
  log_blank
done

separator
log "  Finished: $success succeeded, $fail failed, $skipped skipped (out of $total)"
separator
log_blank
