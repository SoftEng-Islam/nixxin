{ settings, lib, pkgs, ... }:
let
  netShell = pkgs.writeShellScriptBin "netShell" ''
    #!/run/current-system/sw/bin/bash
    
    # Beautiful NetShell Script
    # Provides an interactive menu for network management.
    # author: antigravity
    # license: MIT

    # Colors
    GREEN="\e[32m"
    BLUE="\e[34m"
    CYAN="\e[36m"
    RED="\e[31m"
    YELLOW="\e[33m"
    BOLD="\e[1m"
    RESET="\e[0m"

    print_header() {
        clear
        echo -e "''${CYAN}''${BOLD}=========================================''${RESET}"
        echo -e "''${BLUE}''${BOLD}           NetShell Manager              ''${RESET}"
        echo -e "''${CYAN}''${BOLD}=========================================''${RESET}"
        echo ""
    }

    pause() {
        echo ""
        read -p "Press Enter to continue..."
    }

    show_info() {
        print_header
        echo -e "''${YELLOW}--- Connected Devices & Networks ---''${RESET}"
        nmcli device status
        echo ""

        echo -e "''${YELLOW}--- Local IP Addresses ---''${RESET}"
        ip -brief address show
        echo ""

        echo -e "''${YELLOW}--- Public PC IP Address ---''${RESET}"
        PUBLIC_IP=$(curl -s ifconfig.me || wget -qO- ifconfig.me || echo "Unknown/Offline")
        echo -e "Public IP: ''${GREEN}''${PUBLIC_IP}''${RESET}"
        echo ""

        echo -e "''${YELLOW}--- DNS Servers ---''${RESET}"
        nmcli dev show | grep IP4.DNS | awk '{print $2}'
        pause
    }

    connect_hidden_wifi() {
        print_header
        echo -e "''${YELLOW}--- Connect to Hidden Wi-Fi ---''${RESET}"
        echo -e "Available Wi-Fi interfaces:"
        nmcli device status | grep wifi || echo "No wifi devices found."
        echo ""
        read -p "Enter Wi-Fi SSID (Name): " SSID
        read -s -p "Enter Wi-Fi Password: " PASSWORD
        echo ""
        if [ -n "$SSID" ]; then
            echo -e "''${CYAN}Connecting to hidden network ''${SSID}...''${RESET}"
            nmcli device wifi connect "$SSID" password "$PASSWORD" hidden yes
        else
            echo -e "''${RED}SSID cannot be empty.''${RESET}"
        fi
        pause
    }

    toggle_interface() {
        print_header
        echo -e "''${YELLOW}--- Disable/Enable Interface ---''${RESET}"
        echo -e "Available interfaces:"
        ip -brief link show
        echo ""
        read -p "Enter interface name to disable (or 'cancel' to exit): " IFACE
        if [ "$IFACE" != "cancel" ] && [ -n "$IFACE" ]; then
            echo -e "''${CYAN}Disabling interface ''${IFACE}...''${RESET}"
            # Disconnect via nmcli first, fallback to ip tool
            nmcli device disconnect "$IFACE" || sudo ip link set "$IFACE" down
            echo -e "''${GREEN}Interface ''${IFACE} disabled.''${RESET}"
        fi
        pause
    }

    set_default_source() {
        print_header
        echo -e "''${YELLOW}--- Set Default Internet Source ---''${RESET}"
        echo -e "Active connections:"
        nmcli -t -f NAME,DEVICE,TYPE connection show --active | column -t -s ':' || echo "No active connections or column tool missing."
        echo ""
        echo -e "Note: Lower metric = higher priority."
        read -p "Enter the NAME of the connection to set as default priority: " CONN_NAME
        if [ -n "$CONN_NAME" ]; then
            echo -e "''${CYAN}Setting route-metric to 10 for connection ''${CONN_NAME}...''${RESET}"
            nmcli connection modify "$CONN_NAME" ipv4.route-metric 10
            echo -e "''${CYAN}Applying changes by bringing connection up...''${RESET}"
            nmcli connection up "$CONN_NAME"
            echo -e "''${GREEN}Priority updated successfully.''${RESET}"
        else
            echo -e "''${RED}Connection name cannot be empty.''${RESET}"
        fi
        pause
    }

    while true; do
        print_header
        echo -e "  ''${GREEN}1)''${RESET} Show Network Information"
        echo -e "  ''${GREEN}2)''${RESET} Connect to Hidden Wi-Fi"
        echo -e "  ''${GREEN}3)''${RESET} Disable Internet for Selected Device"
        echo -e "  ''${GREEN}4)''${RESET} Set Default Internet Source"
        echo -e "  ''${RED}5)''${RESET} Exit"
        echo ""
        read -p "Select an option [1-5]: " OPTION

        case $OPTION in
            1) show_info ;;
            2) connect_hidden_wifi ;;
            3) toggle_interface ;;
            4) set_default_source ;;
            5) clear; exit 0 ;;
            *) echo -e "''${RED}Invalid option.''${RESET}"; sleep 1 ;;
        esac
    done
  '';
in { environment.systemPackages = [ netShell ]; }
