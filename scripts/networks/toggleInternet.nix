{ settings, lib, pkgs, ... }:
let
  toggleInternet = pkgs.writeShellScriptBin "toggleInternet" ''
    #!/run/current-system/sw/bin/bash
    # This script will disable/enable the Internet connection
    # It requires root privileges to run
    # Usage: toggleInternet
    # Check if the script is run as root
    if [ "$EUID" -ne 0 ]; then
      echo "Please run as root"
      ${pkgs.libnotify}/bin/notify-send --icon=~/.nixxinIcons/globe.svg "Toggle_Internet.sh" "Please run as root"
      exit
    fi

    # Function to disable all network interfaces except loopback
    disable_internet() {
      echo "Disabling all network interfaces except loopback..."

      # Get a list of all network interfaces except loopback
      interfaces=$(ip -o link show | awk -F': ' '{print $2}' | grep -v lo)
      for iface in $interfaces; do
        echo "Disabling interface: $iface"
        ip link set "$iface" down
      done
      echo "All network interfaces except loopback have been disabled."
      ${pkgs.libnotify}/bin/notify-send --icon=~/.nixxinIcons/globe.svg "Toggle_Internet.sh" "All network interfaces except loopback have been disabled."

    }

    # Function to enable all network interfaces except loopback
    enable_internet() {
      echo "Enabling all network interfaces except loopback..."
      # Get a list of all network interfaces except loopback
      interfaces=$(ip -o link show | awk -F': ' '{print $2}' | grep -v lo)
      for iface in $interfaces; do
        echo "Enabling interface: $iface"
        ip link set "$iface" up
      done
      echo "All network interfaces except loopback have been enabled."
      ${pkgs.libnotify}/bin/notify-send --icon=~/.nixxinIcons/globe.svg "Toggle_Internet.sh" "All network interfaces except loopback have been enabled."

    }

    # Check the current status of the network interfaces
    current_status=$(ip link show | grep -v lo | grep -q "state UP" && echo "up" || echo "down")
    if [ "$current_status" = "up" ]; then
      disable_internet
    else
      enable_internet
    fi
    exit 0

  '';
in { environment.systemPackages = [ toggleInternet ]; }
