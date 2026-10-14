{ settings, lib, pkgs, ... }:
let
  wifiMode = pkgs.writeShellScriptBin "wifiMode" ''
    #!/run/current-system/sw/bin/bash
    #
    # Manage WiFi interface modes (Normal / Managed vs. Monitor)
    # Usage:
    #   wifiMode [normal|managed|monitor|toggle|status] [interface]
    #   wifiMode [interface] (toggles mode)
    #   wifiMode (toggles mode on default wireless interface)
    #
    set -e

    ACTION="toggle"
    INTERFACE=""

    for arg in "$@"; do
      case "$arg" in
        normal|managed|station)
          ACTION="normal"
          ;;
        monitor)
          ACTION="monitor"
          ;;
        toggle)
          ACTION="toggle"
          ;;
        status)
          ACTION="status"
          ;;
        *)
          if [ -z "$INTERFACE" ]; then
            INTERFACE="$arg"
          fi
          ;;
      esac
    done

    # If interface is not specified, auto-detect
    if [ -z "$INTERFACE" ]; then
      if ip link show wlan0 > /dev/null 2>&1; then
        INTERFACE="wlan0"
      else
        INTERFACE=$(iw dev 2>/dev/null | awk '$1=="Interface"{print $2; exit}')
      fi
    fi

    if [ -z "$INTERFACE" ]; then
      echo "Error: No wireless interface detected."
      exit 1
    fi

    if ! ip link show "$INTERFACE" > /dev/null 2>&1; then
      echo "Error: Interface $INTERFACE does not exist."
      exit 1
    fi

    get_mode() {
      iw dev "$INTERFACE" info 2>/dev/null | grep type | awk '{print $2}'
    }

    notify() {
      local title="$1"
      local msg="$2"
      local icon="$3"
      if [ -n "$DISPLAY" ] || [ -n "$WAYLAND_DISPLAY" ]; then
        if command -v notify-send > /dev/null 2>&1; then
          notify-send -u normal -i "$icon" "$title" "$msg" 2>/dev/null || true
        fi
      fi
    }

    set_normal() {
      echo "==> Switching $INTERFACE to NORMAL (managed) mode..."

      # Bring interface down
      sudo ip link set "$INTERFACE" down 2>/dev/null || true

      # Set type to managed
      sudo iw dev "$INTERFACE" set type managed 2>/dev/null || true

      # Bring interface back up
      sudo ip link set "$INTERFACE" up 2>/dev/null || true

      # Ensure NetworkManager service is active
      if ! systemctl is-active --quiet NetworkManager.service 2>/dev/null; then
        echo "Starting NetworkManager service..."
        sudo systemctl start NetworkManager.service || true
        sleep 1
      fi

      # Tell NetworkManager to manage this interface
      if command -v nmcli > /dev/null 2>&1; then
        echo "Setting NetworkManager to manage $INTERFACE..."
        sudo nmcli device set "$INTERFACE" managed yes 2>/dev/null || true
        # Trigger Wi-Fi rescan so nearby SSIDs immediately appear
        sudo nmcli device wifi rescan ifname "$INTERFACE" 2>/dev/null || true
      fi

      MODE=$(get_mode)
      if [ "$MODE" = "managed" ]; then
        echo "Successfully set $INTERFACE to NORMAL (managed) mode."
        echo "You can now connect to Wi-Fi networks (e.g. via nmcli or network applet)."
        notify "WiFi Mode" "$INTERFACE switched to Normal (Managed) mode" "network-wireless"
        exit 0
      else
        echo "Warning: Mode is currently '$MODE'. Expected 'managed'."
        exit 1
      fi
    }

    set_monitor() {
      echo "==> Switching $INTERFACE to MONITOR mode..."

      # Disable NetworkManager on the interface to avoid interference
      if command -v nmcli > /dev/null 2>&1; then
        echo "Disabling NetworkManager management on $INTERFACE..."
        sudo nmcli device set "$INTERFACE" managed no 2>/dev/null || true
      fi

      # Bring interface down
      sudo ip link set "$INTERFACE" down 2>/dev/null || true

      # Set type to monitor
      sudo iw dev "$INTERFACE" set type monitor 2>/dev/null || true

      # Bring interface back up
      sudo ip link set "$INTERFACE" up 2>/dev/null || true

      MODE=$(get_mode)
      if [ "$MODE" = "monitor" ]; then
        echo "Successfully set $INTERFACE to MONITOR mode."
        echo "Interface is ready for testing tools (wifite, hcxdumptool, etc.)."
        notify "WiFi Mode" "$INTERFACE switched to Monitor mode" "network-wireless-offline"
        exit 0
      else
        echo "Failed to set $INTERFACE to monitor mode (current: $MODE)."
        exit 1
      fi
    }

    show_status() {
      echo "Interface: $INTERFACE"
      echo "Mode:      $(get_mode)"
      echo "State:     $(cat /sys/class/net/$INTERFACE/operstate 2>/dev/null || ip -br link show $INTERFACE | awk '{print $2}')"
      if command -v nmcli > /dev/null 2>&1; then
        NM_STATE=$(nmcli -t -f DEVICE,STATE dev 2>/dev/null | grep "^$INTERFACE:" | cut -d: -f2 || echo "unknown")
        echo "NM State:  $NM_STATE"
      fi
    }

    case "$ACTION" in
      normal)
        set_normal
        ;;
      monitor)
        set_monitor
        ;;
      status)
        show_status
        ;;
      toggle)
        CURRENT=$(get_mode)
        if [ "$CURRENT" = "monitor" ]; then
          set_normal
        else
          set_monitor
        fi
        ;;
    esac
  '';

  wifiNormalMode = pkgs.writeShellScriptBin "wifiNormalMode" ''
    #!/run/current-system/sw/bin/bash
    exec ${wifiMode}/bin/wifiMode normal "$@"
  '';

  wifiMonitorMode = pkgs.writeShellScriptBin "wifiMonitorMode" ''
    #!/run/current-system/sw/bin/bash
    exec ${wifiMode}/bin/wifiMode monitor "$@"
  '';

  wifiToggleMode = pkgs.writeShellScriptBin "wifiToggleMode" ''
    #!/run/current-system/sw/bin/bash
    exec ${wifiMode}/bin/wifiMode toggle "$@"
  '';
in
{
  environment.systemPackages = [
    wifiMode
    wifiNormalMode
    wifiMonitorMode
    wifiToggleMode
  ];
}
