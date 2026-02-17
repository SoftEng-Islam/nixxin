{ pkgs, ... }:
# Source: https://wiki.hyprland.org/Configuring/Uncommon-tips--tricks/
# For increased performance in games, or for less distractions at a keypress
# Edit to your liking of course. If animations are enabled, it disables all the pretty stuff. Otherwise, the script reloads your config to grab your defaults.
# Hotkey is configured in Hyprland keybindings (this repo uses $main+F2).
let
  runGamemode = pkgs.writeShellScriptBin "run-gamemode" ''
    set -u
    set -o pipefail

    STATE_DIR="''${XDG_RUNTIME_DIR:-/tmp}/nixxin-gamemode"
    ENABLED_MARKER="''${STATE_DIR}/enabled"
    PREV_PROFILE_FILE="''${STATE_DIR}/power_profile_before"

    HYPRSHADE="${pkgs.hyprshade}/bin/hyprshade"
    NOTIFY="${pkgs.libnotify}/bin/notify-send"
    # GAMEMODED="${pkgs.gamemode}/bin/gamemoded"

    have() { command -v "$1" >/dev/null 2>&1; }

    notify() {
      local title="$1"
      local body="$2"
      if [[ -x "$NOTIFY" ]]; then
        "$NOTIFY" "$title" "$body" >/dev/null 2>&1 || true
      fi
    }

    hypr_ok() {
      have hyprctl || return 1
      hyprctl getoption animations:enabled >/dev/null 2>&1 || return 1
      return 0
    }

    read1() {
      local path="$1"
      [[ -r "$path" ]] || return 1
      head -n 1 "$path" 2>/dev/null
    }

    write_sysfs() {
      local path="$1"
      local value="$2"
      [[ -e "$path" ]] || return 0

      # Direct write if possible (rare).
      if [[ -w "$path" ]]; then
        printf '%s\n' "$value" >"$path" 2>/dev/null || true
        return 0
      fi

      # Non-interactive sudo only (Hyprland keybind has no tty).
      if have sudo && sudo -n true 2>/dev/null; then
        printf '%s\n' "$value" | sudo -n tee "$path" >/dev/null 2>/dev/null || true
      fi
    }

    detect_amd_card() {
      local card
      for card in /sys/class/drm/card*; do
        [[ -r "$card/device/vendor" ]] || continue
        [[ "$(read1 "$card/device/vendor" || true)" == "0x1002" ]] || continue
        echo "$card"
        return 0
      done
      return 1
    }

    enable_mode() {
      mkdir -p "$STATE_DIR" 2>/dev/null || true

      # Store current profile so we can restore it later.
      if have powerprofilesctl; then
        powerprofilesctl get 2>/dev/null | head -n 1 >"$PREV_PROFILE_FILE" 2>/dev/null || true
        powerprofilesctl set performance >/dev/null 2>&1 || true
      fi

      # Start GameMode daemon if available.
      # if [[ -x "$GAMEMODED" ]]; then
      #  "$GAMEMODED" >/dev/null 2>&1 &
      # fi

      # Try to force AMD GPU to higher performance (best-effort; usually needs sudo NOPASSWD).
      local amd_card
      amd_card="$(detect_amd_card 2>/dev/null || true)"
      if [[ -n "$amd_card" ]]; then
        write_sysfs "$amd_card/device/power_dpm_force_performance_level" "high"
        write_sysfs "$amd_card/device/power_dpm_state" "performance"
      fi

      # Stop distractions.
      if have noctalia-shell; then
        noctalia-shell kill >/dev/null 2>&1 || true
      fi

      # Apply Hyprland "game mode" tweaks.
      hyprctl --batch "\
        keyword animations:enabled 0;\
        keyword decoration:shadow:enabled 0;\
        keyword decoration:blur:enabled 0;\
        keyword general:gaps_in 0;\
        keyword general:gaps_out 0;\
        keyword general:border_size 0;\
        keyword decoration:rounding 0" >/dev/null 2>&1 || true

      : >"$ENABLED_MARKER" 2>/dev/null || true
      notify "GameMode" "Enabled"
    }

    disable_mode() {
      # Capture current hyprshade state (reload can reset shaders).
      local hyprshade_current=""
      if [[ -x "$HYPRSHADE" ]]; then
        hyprshade_current="$("$HYPRSHADE" current 2>/dev/null || true)"
      fi

      hyprctl reload >/dev/null 2>&1 || true
      sleep 0.5

      if [[ "$hyprshade_current" == "blue-light-filter" ]]; then
        "$HYPRSHADE" on ~/.config/hypr/shaders/blue-light-filter.glsl >/dev/null 2>&1 || true
        notify "Blue Filter" "Restored"
      fi

      if have noctalia-shell; then
        noctalia-shell -n >/dev/null 2>&1 &
      fi

      # Restore previous power profile if we captured it.
      if have powerprofilesctl && [[ -r "$PREV_PROFILE_FILE" ]]; then
        prev_profile="$(head -n 1 "$PREV_PROFILE_FILE" 2>/dev/null || true)"
        if [[ -n "$prev_profile" ]]; then
          powerprofilesctl set "$prev_profile" >/dev/null 2>&1 || true
        fi
      fi

      rm -rf "$STATE_DIR" 2>/dev/null || true
      notify "GameMode" "Disabled"
    }

    usage() {
      cat <<'EOF'
      run-gamemode [toggle|on|off|status]

      Default: toggle.
      EOF
    }

    action="''${1:-toggle}"

    if ! hypr_ok; then
      notify "GameMode" "Hyprland not detected (hyprctl failed)"
      exit 1
    fi

    case "$action" in
      toggle)
        if [[ -e "$ENABLED_MARKER" ]]; then
          disable_mode
        else
          enable_mode
        fi
        ;;
      on|enable) enable_mode ;;
      off|disable) disable_mode ;;
      status)
        if [[ -e "$ENABLED_MARKER" ]]; then
          echo "enabled"
        else
          echo "disabled"
        fi
        ;;
      -h|--help|help) usage ;;
      *)
        usage
        exit 2
        ;;
    esac
  '';
in
{
  environment.systemPackages = [ runGamemode ];
}
