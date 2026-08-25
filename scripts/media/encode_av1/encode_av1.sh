#!/usr/bin/env bash

# ============================================================
# AV1 Batch Video Encoder (Auto-Scales > 1080p down to 1080p)
# Encodes a list of videos to AV1 (libsvtav1) with audio copy
# ============================================================

# --- Configuration ---
CODEC="libsvtav1"

PRESET="8"		# 0-13 (8-10 is a good balance for speed/quality)

CRF="30"		# Constant Rate Factor (24-30 is typical. 30 ensures high compression)
                # Only used when BITRATE below is left empty.

# --- Static/target bitrate (optional) ---
# Leave BITRATE empty to keep encoding with CRF (quality-based, variable output size).
# Set BITRATE to switch to bitrate-based encoding instead (CRF is ignored when this is set).
#   Examples: "4000k", "6M"
BITRATE=""
# Only used when BITRATE is set:
#   MAXRATE caps short-term peaks above BITRATE. Set it equal to BITRATE for
#   near-constant (CBR-like) output, or higher to allow some headroom (capped VBR).
#   BUFSIZE is the rate-control buffer size (commonly 1-2x BITRATE). MAXRATE has
#   no effect unless BUFSIZE is also set.
MAXRATE="" # 4500k
BUFSIZE="" # 9000k

# --- Downscaling toggle ---
# When "true": any source video taller than 1080p (2K/4K/etc.) is scaled down
# to 1080p before encoding. When "false": videos are encoded at their native
# resolution regardless of height.
SCALE_DOWN_ABOVE_1080P="false"

AUDIO_CODEC="copy"
OUTPUT_EXT="mkv"
LOG_FILE="status.txt"

# --- Define your video list here ---
VIDEOS=(
  "video1.mp4"
  "video2.mov"
  "video3.avi"
)

# --- Helper functions ---

log() {
  echo "$*"
  echo "$*" >> "$LOG_FILE"
}

log_blank() {
  echo ""
  echo "" >> "$LOG_FILE"
}

separator() {
  log "============================================================"
}

get_duration() {
  ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$1" 2>/dev/null
}

format_time() {
  local total_seconds="${1%.*}"
  if [[ -z "$total_seconds" || "$total_seconds" == "N/A" ]]; then
    echo "Unknown"
    return
  fi
  local hours=$((total_seconds / 3600))
  local minutes=$(( (total_seconds % 3600) / 60 ))
  local seconds=$((total_seconds % 60))
  printf "%02d:%02d:%02d" "$hours" "$minutes" "$seconds"
}

print_video_info() {
  local file="$1"
  log "  File     : $file"
  local dur
  dur=$(get_duration "$file")
  log "  Duration : $(format_time "$dur")"

  local vinfo
  vinfo=$(ffprobe -v error -select_streams v:0 \
    -show_entries stream=codec_name,width,height,bit_rate,r_frame_rate \
    -of default=noprint_wrappers=1 "$file" 2>/dev/null)

  # Note: 'height' is intentionally kept global here so the main loop can check it
  local vcodec width fps bitrate
  vcodec=$(echo "$vinfo" | grep "^codec_name=" | cut -d= -f2)
  width=$(echo "$vinfo"  | grep "^width="      | cut -d= -f2)
  height=$(echo "$vinfo" | grep "^height="     | cut -d= -f2)
  fps=$(echo "$vinfo"    | grep "^r_frame_rate="| cut -d= -f2)
  bitrate=$(echo "$vinfo"| grep "^bit_rate="   | cut -d= -f2)
  log "  Video    : ${vcodec:-N/A}, ${width:-?}x${height:-?}, ${fps:-N/A} fps, bitrate ${bitrate:-N/A}"

  local size
  size=$(du -h "$file" 2>/dev/null | cut -f1)
  log "  Size     : ${size:-N/A}"
}

# --- Main ---

# Build the rate-control arguments once (same for every video in the batch).
#
# SVT-AV1 only accepts -maxrate (its "mbr" parameter) alongside CRF-based
# rate control. Combining -b:v (VBR mode) with -maxrate fails with:
#   "Svt[error]: Max Bitrate only supported with CRF mode"
# So BITRATE and MAXRATE are mutually exclusive rate-control strategies here:
#   - BITRATE set   -> plain VBR targeting that average bitrate, peaks uncapped
#   - MAXRATE set (BITRATE empty) -> "capped CRF": quality-driven like normal
#     CRF, but with a hard ceiling on bitrate spikes
RATE_ARGS=()
if [[ -n "$BITRATE" ]]; then
  if [[ -n "$MAXRATE" || -n "$BUFSIZE" ]]; then
    log "  [WARN] MAXRATE/BUFSIZE are ignored when BITRATE is set (SVT-AV1's"
    log "         VBR mode doesn't support a hard cap). Leave BITRATE empty"
    log "         and set MAXRATE instead for capped-CRF mode."
    log_blank
  fi
  RATE_ARGS=(-b:v "$BITRATE")
  RATE_MODE_DESC="target bitrate $BITRATE (VBR, uncapped peaks)"
elif [[ -n "$MAXRATE" ]]; then
  RATE_ARGS=(-crf "$CRF" -maxrate "$MAXRATE")
  [[ -n "$BUFSIZE" ]] && RATE_ARGS+=(-bufsize "$BUFSIZE")
  RATE_MODE_DESC="capped CRF $CRF (maxrate $MAXRATE"
  [[ -n "$BUFSIZE" ]] && RATE_MODE_DESC+=", bufsize $BUFSIZE"
  RATE_MODE_DESC+=")"
else
  RATE_ARGS=(-crf "$CRF")
  RATE_MODE_DESC="CRF $CRF"
fi

total=${#VIDEOS[@]}

log_blank
separator
log "  AV1 Batch Encoder — $total video(s) queued"
log "  Rate control: $RATE_MODE_DESC"
log "  Downscale >1080p to 1080p: $SCALE_DOWN_ABOVE_1080P"
separator
log_blank

success=0
fail=0
skipped=0

for i in "${!VIDEOS[@]}"; do
  input="${VIDEOS[$i]}"
  num=$((i + 1))
  base="${input%.*}"
  output="${base}.${OUTPUT_EXT}"

  if [[ "$input" == "$output" ]]; then
    output="${base}.av1.${OUTPUT_EXT}"
  fi

  separator
  log "[$num/$total] Encoding: $input"
  separator

  if [[ ! -f "$input" ]]; then
    log "[SKIP] File not found: $input"
    log_blank
    ((skipped++))
    continue
  fi

  # Extract video info (this sets the $height variable for the next step)
  print_video_info "$input"
  log_blank

  # --- RESOLUTION CHECK & SCALE FILTER ---
  # Safely check if height exists and is greater than 1080, and honor the
  # SCALE_DOWN_ABOVE_1080P toggle
  if [[ "$SCALE_DOWN_ABOVE_1080P" == "true" ]] && [[ -n "$height" ]] && [[ "$height" -gt 1080 ]]; then
      log "  Detected resolution > 1080p ($height px). Scaling to 1080p."
      SCALE_FILTER="-vf scale=-2:1080"
  else
      if [[ -n "$height" ]] && [[ "$height" -gt 1080 ]]; then
        log "  Detected resolution > 1080p ($height px), but downscaling is disabled. Keeping native resolution."
      fi
      SCALE_FILTER=""
  fi

  start_time=$(date +%s)

  # --- ENCODE COMMAND ---
  # nice -n 19: lowest CPU priority for system stability
  # lp=4: Limits the encoder to 4 logical processors
  # loglevel bumped to "info" so SVT-AV1's own "Svt[error]: ..." line (the
  # actual reason behind any "bad parameter" failure) shows up instead of
  # being swallowed by "warning" level.
  ffmpeg_stderr=$(mktemp)
  nice -n 19 ffmpeg -hide_banner -loglevel warning -stats -y -i "$input" \
    $SCALE_FILTER \
    -pix_fmt yuv420p10le \
    -c:v "$CODEC" -preset "$PRESET" "${RATE_ARGS[@]}" \
    -svtav1-params "lp=4" \
    -c:a "$AUDIO_CODEC" "$output"
  exit_code=$?
  tail -n 40 "$ffmpeg_stderr"
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
    log "  --- ffmpeg/SVT-AV1 diagnostic output ---"
    # Pull out the actual SVT-AV1 error line(s) so the real cause is in the log,
    # not just ffmpeg's generic "bad parameter" wrapper message.
    grep -E "Svt\[(error|warn)\]|Error setting encoder parameters" "$ffmpeg_stderr" >> "$LOG_FILE"
    log "  (full ffmpeg stderr saved separately if needed)"
    cp "$ffmpeg_stderr" "${base}.ffmpeg_error.log"
    ((fail++))
  fi
  rm -f "$ffmpeg_stderr"

  # Cooldown period to protect hardware
  log "Cooling down for 60 seconds..."
  sleep 60
  log_blank
done

separator
log "  Finished: $success succeeded, $fail failed, $skipped skipped (out of $total)"
separator
log_blank
