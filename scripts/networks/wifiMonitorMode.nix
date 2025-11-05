{ settings, lib, pkgs, ... }:
let
  wifiMonitorMode = pkgs.writeShellScriptBin "wifiMonitorMode" ''
    #!/run/current-system/sw/bin/bash
    # function to enable monitor mode on a specified wifi interface
    # usage: wifiMonitorMode.sh <interface>
    # example: wifiMonitorMode.sh wlan0
    # requires: iw, ip, airmon-ng, sudo
    # author: Islam Ahmed (softeng)
    # date: 2024-10-01
    # license: MIT
    # version: 1.0
    # description: This script enables monitor mode on a specified wifi interface using iw and ip commands.
    # It requires sudo privileges to execute the necessary commands.
    # It also disables NetworkManager on the specified interface to avoid conflicts.
    # Note: This script is intended for educational purposes only. Use it responsibly and ensure you have permission to monitor the network.
    # Check if the interface argument is provided
    if [ -z "$1" ]; then
      echo "Usage: $0 <interface>"
      exit 1
    fi

    INTERFACE="$1"
    # Check if the interface exists
    if ! ip link show "$INTERFACE" > /dev/null 2>&1; then
      echo "Error: Interface $INTERFACE does not exist."
      exit 1
    fi

    # Disable NetworkManager on the interface to avoid conflicts
    if command -v nmcli > /dev/null 2>&1; then
      echo "Disabling NetworkManager on $INTERFACE..."
      nmcli device set "$INTERFACE" managed no
      sudo airmon-ng check kill
    fi
    # Bring the interface down
    echo "Bringing down the interface $INTERFACE..."
    sudo ip link set "$INTERFACE" down
    # Set the interface to monitor mode
    echo "Setting $INTERFACE to monitor mode..."
    sudo iw "$INTERFACE" set monitor control
    # Bring the interface up
    echo "Bringing up the interface $INTERFACE..."
    sudo ip link set "$INTERFACE" up
    # Verify the mode change
    MODE=$(iw dev "$INTERFACE" info | grep type | awk '{print $2}')
    if [ "$MODE" = "monitor" ]; then
      echo "Successfully set $INTERFACE to monitor mode."
      exit 0
    else
      echo "Failed to set $INTERFACE to monitor mode."
      exit 1
    fi
  '';
in { environment.systemPackages = [ wifiMonitorMode ]; }
