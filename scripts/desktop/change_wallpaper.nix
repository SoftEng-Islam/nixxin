{ settings, config, lib, pkgs, ... }:
let
  changeWallpaper = pkgs.writeShellScriptBin "changeWallpaper" ''
    #!/usr/bin/env bash

    # ---- SWWW & Set Image as Background ---- #
    # ${pkgs.swww}/bin/swww-daemon --no-cache --format xrgb &
    # ${pkgs.swww}/bin/swww img ~/Pictures/desktop.png --transition-bezier .43,1.19,1,.4 --transition-fps 30 --transition-type grow --transition-pos 0.925,0.977 --transition-duration 2

    set -euo pipefail

    CACHE_DIR="/home/${settings.user.username}/.cache/changeWallpaper"
    STATE_FILE="$CACHE_DIR/state"
    WALLPAPER_DIR="/home/${settings.user.username}/Pictures/wallpapers"

    mkdir -p "$CACHE_DIR"

    # User-configurable time (change as needed)
    # The Image Will stay for a spacific time before go to next one
    DAYS=0
    HOURS=6
    MINUTES=0

    # Convert total time to seconds
    INTERVAL=$(( (DAYS*24*60*60) + (HOURS*60*60) + (MINUTES*60) ))

    # Ensure swww daemon running
    if ! pgrep -x "swww-daemon" >/dev/null; then
      ${pkgs.swww}/bin/swww-daemon --no-cache &
      sleep 1
    else
      echo "swww-daemon already running, skipping startup."
    fi

    # Collect wallpapers
    mapfile -t IMAGES < <(find "$WALLPAPER_DIR" -type f \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' \) | sort)
    TOTAL=''${#IMAGES[@]}
    if (( TOTAL == 0 )); then
      echo "No images found in $WALLPAPER_DIR"
      exit 1
    fi

    # Function to set wallpaper
    set_wall() {
        local img="$1"
        echo "Setting wallpaper: $img"
        ${pkgs.swww}/bin/swww img "$img" \
            --transition-bezier .43,1.19,1,.4 \
            --transition-type grow \
            --transition-fps 30 \
            --transition-pos 0.925,0.977 \
            --transition-duration 2 \
            --transition-angle 30
    }

    # Restore state
    if [[ -f "$STATE_FILE" ]]; then
      INDEX=0
      LAST_CHANGED=0
      source "$STATE_FILE"
    else
      INDEX=0
      LAST_CHANGED=0
    fi

    NOW=$(date +%s)
    ELAPSED=$((NOW - LAST_CHANGED))

    # Handle startup state
    if [[ ! -f "$STATE_FILE" ]]; then
        # First run, start fresh
        set_wall "''${IMAGES[$INDEX]}"
        LAST_CHANGED=$(date +%s)
        echo "INDEX=$INDEX" > "$STATE_FILE"
        echo "LAST_CHANGED=$LAST_CHANGED" >> "$STATE_FILE"
        sleep "$INTERVAL"
    elif (( ELAPSED < INTERVAL )); then
        # Resume waiting
        echo "Resuming previous wallpaper..."
        set_wall "''${IMAGES[$INDEX]}"
        sleep $((INTERVAL - ELAPSED))
    fi

    # Main Loop
    while true; do
      INDEX=$(( (INDEX + 1) % TOTAL ))
      set_wall "''${IMAGES[$INDEX]}"

      LAST_CHANGED=$(date +%s)
      echo "INDEX=$INDEX" > "$STATE_FILE"
      echo "LAST_CHANGED=$LAST_CHANGED" >> "$STATE_FILE"

      sleep "$INTERVAL"
    done
  '';
in {
  home-manager.users.${settings.user.username} = {
    home.packages = [ changeWallpaper ];
    # home.file."Pictures/wallpapers".source = builtins.toPath ../Wallpapers;
  };
  environment.systemPackages = with pkgs; [ swww ];
}
