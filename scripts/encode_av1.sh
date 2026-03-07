#!/usr/bin/env bash

# ============================================================
# AV1 Batch Video Encoder
# Encodes a list of videos to AV1 (libsvtav1) with audio copy
# ============================================================

# --- Configuration ---
CODEC="libsvtav1"
AUDIO_CODEC="copy"
OUTPUT_EXT="mkv"

# --- Define your video list here ---
# Add or remove entries as needed. Each entry is the input filename.
VIDEOS=(
  "Beata - I love outdoor fucking.mp4"
  #"Alyssia_Kent Alice_Hernandez Maid_To_Massage.mp4"
  #"Brooklyn_Blue The Fake Doctor.mp4"
  #"Eva Lovia - Let It Ride - scene 1.mp4"
  #"Holly Michaels and Jeovanni Francesco.mp4"
  #"[OyeLoca] 18.04.11 Darcia.mp4"
  #"Brazzers — Kleio Valentien, Nikki Hearts — Kinky Dungeon (2014).mp4"
  #"Evelin Stone - [TheRealWorkout.com] - [2017] - Foreign Boy Meets Thirsty Fitness Model.mp4"
)

# --- Helper functions ---

# Print a separator line
separator() {
  echo "============================================================"
  echo "============================================================" >> status.txt
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
  echo "  File     : $file"

  # Duration
  local dur
  dur=$(get_duration "$file")
  echo "  Duration : $(format_time "$dur")"

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

  echo "  Video    : ${vcodec:-N/A}, ${width:-?}x${height:-?}, ${fps:-N/A} fps, bitrate ${bitrate:-N/A}"

  # Audio stream info
  local ainfo
  ainfo=$(ffprobe -v error -select_streams a:0 \
    -show_entries stream=codec_name,sample_rate,channels \
    -of default=noprint_wrappers=1 "$file" 2>/dev/null)

  local acodec sample_rate channels
  acodec=$(echo "$ainfo"      | grep "^codec_name="  | cut -d= -f2)
  sample_rate=$(echo "$ainfo" | grep "^sample_rate="  | cut -d= -f2)
  channels=$(echo "$ainfo"    | grep "^channels="     | cut -d= -f2)

  echo "  Audio    : ${acodec:-N/A}, ${sample_rate:-N/A} Hz, ${channels:-N/A} ch"

  # File size
  local size
  size=$(du -h "$file" 2>/dev/null | cut -f1)
  echo "  Size     : ${size:-N/A}"
}

# --- Main ---

total=${#VIDEOS[@]}

echo "" && echo "" >> status.txt
separator
echo "  AV1 Batch Encoder — $total video(s) queued" && echo "  AV1 Batch Encoder — $total video(s) queued" >> status.txt
separator
echo "" && echo "" >> status.txt

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
  echo "[$num/$total] Encoding: $input" && echo "[$num/$total] Encoding: $input" >> status.txt
  separator

  # Check if input file exists
  if [[ ! -f "$input" ]]; then
    echo "[SKIP] File not found: $input" && echo "[SKIP] File not found: $input" >> status.txt
    echo "" && echo "" >> status.txt
    ((skipped++))
    continue
  fi

  # Print info about the source video
  print_video_info "$input"
  print_video_info "$input" >> status.txt
  echo "" && echo "" >> status.txt

  # Record start time
  start_time=$(date +%s)

  # Encode
  ffmpeg -i "$input" -vcodec "$CODEC" -c:a "$AUDIO_CODEC" "$output" -y

  exit_code=$?
  end_time=$(date +%s)
  elapsed=$((end_time - start_time))

  if [[ $exit_code -eq 0 ]]; then
    out_size=$(du -h "$output" 2>/dev/null | cut -f1)
    echo "" && echo "" >> status.txt
    echo "[DONE!] $output  (size: ${out_size:-N/A}, took: $(format_time $elapsed))"
    echo "[DONE!] $output  (size: ${out_size:-N/A}, took: $(format_time $elapsed))" >> status.txt
    ((success++))
  else
    echo "" && echo "" >> status.txt
    echo "[FAILED!] $input  (exit code: $exit_code, after: $(format_time $elapsed))"
    echo "[FAILED!] $input  (exit code: $exit_code, after: $(format_time $elapsed))" >> status.txt
    ((fail++))
  fi
  echo "" && echo "" >> status.txt
done

separator
echo "  Finished: $success succeeded, $fail failed, $skipped skipped (out of $total)"
echo "  Finished: $success succeeded, $fail failed, $skipped skipped (out of $total)" >> status.txt
separator
echo "" && echo "" >> status.txt
