{ mySettings, pkgs, ... }: {
  networking = {
    networkmanager = {
      enable = true;
      wifi.powersave = false;
      dns = "dnsmasq";
      # increase boot speed
      wifi.backend = "iwd";
    };
    hostName = mySettings.hostName; # Define your hostname.
    # interfaces.${wifiInterface}.useDHCP = true;
    nftables.enable = true;
    dhcpcd.enable = false;
    useNetworkd = false;
    firewall = { enable = false; };

    # useNetworkd = true;
    firewall.extraCommands = ''
      iptables -t nat -A POSTROUTING -o wlan1 -j MASQUERADE
      iptables -A FORWARD -i wlan1 -o eno1 -m state --state RELATED,ESTABLISHED -j ACCEPT
      iptables -A FORWARD -i eno1 -o wlan1 -j ACCEPT
    '';
    nameservers =
      [ "8.8.8.8" "8.8.4.4" "2001:4860:4860::8888" "2001:4860:4860::8844" ];
    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~
    # ~~~~ Wireless Settings ~~~~
    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~
    # If your system only uses a wired Ethernet connection, you can disable wireless support to simplify your configuration and save resources.
    # wireless.enable = false;  # wpa_supplicant.

    # Wireless configuration
    # Using IWD (iNet Wireless Daemon) instead of WPA Supplicant for:
    # - WPA2, WPA3, and Enterprise authentication.
    # - Improved performance and resource usage.
    # - Integration with NetworkManager/systemd-networkd.
    wireless.iwd = {
      # Example commands manage Wi-Fi connections:
      #- iwctl
      #-- device list             # List wireless devices
      #-- station wlan0 scan      # Scan for networks
      #-- station wlan0 get-networks  # Show available networks
      #-- station wlan0 connect SSID  # Connect to a network
      enable = true;
      settings = {
        Network = {
          EnableIPv6 = true;
          RoutePriorityOffset = 300;
        };
        # MAC address randomization
        General = {
          AddressRandomization = "once";
          AddressRandomizationRange = "full";
          EnableNetworkConfiguration = true;
        };
        Settings.AutoConnect = true;
      };
    };
    # extraHosts = ''
    #   127.0.0.1 softeng.home
    # '';
  };

  services = {
    hostapd.enable = false;
    resolved.enable = false; # systemd DNS resolver daemon, systemd-resolved.
    dnsmasq = {
      # Configure dnsmasq
      enable = true;
      alwaysKeepRunning = true;
      settings = {
        # Set Google DNS for IPv4 and IPv6
        server =
          [ "8.8.8.8" "8.8.4.4" "2001:4860:4860::8888" "2001:4860:4860::8844" ];
        # Provide DHCP settings (if applicable)
        dhcpRange = "10.42.0.10,10.42.0.100,12h"; # Adjust to your network
        dhcpLeaseTime = "12h";
      };
    };
  };
  networking.hosts = {
    #    "0.0.0.0" = [
    #      "overseauspider.yuanshen.com"
    #      "log-upload-os.hoyoverse.com"
    #      "log-upload-os.mihoyo.com"
    #      "dump.gamesafe.qq.com"
    #
    #      "log-upload.mihoyo.com"
    #      "devlog-upload.mihoyo.com"
    #      "uspider.yuanshen.com"
    #      "sg-public-data-api.hoyoverse.com"
    #      "public-data-api.mihoyo.com"
    #
    #      "prd-lender.cdp.internal.unity3d.com"
    #      "thind-prd-knob.data.ie.unity3d.com"
    #      "thind-gke-usc.prd.data.corp.unity3d.com"
    #      "cdp.cloud.unity3d.com"
    #      "remote-config-proxy-prd.uca.cloud.unity3d.com"
    #    ];
  };
  environment.systemPackages = with pkgs; [
    sipcalc # Advanced console ip subnet calculator
    iperf # Tool to measure IP bandwidth using UDP or TCP
    netcat # Free TLS/SSL implementation
    mtr # Network diagnostics tool
    tcpdump # Network sniffer
    bandwhich # CLI utility for displaying current network utilization
    dnsutils # Domain name server

    linuxPackages.rtl8188eus-aircrack # RealTek RTL8188eus WiFi driver with monitor mode & frame injection support
    ntp # An implementation of the Network Time Protocol
    openresolv # A program to manage /etc/resolv.conf
    radvd # IPv6 Router Advertisement Daemon
    tcpdump # Network sniffer
    nssmdns # The mDNS Name Service Switch (NSS) plug-in
    nmap # A free and open source utility for network discovery and security auditing
    networkmanager
    networkmanagerapplet # NetworkManager control applet for GNOME
    networkmanager-openconnect # NetworkManager’s OpenConnect plugin
    wirelesstools # Wireless tools for Linux
    inetutils # Collection of common network programs
    ipset # Administration tool for IP sets
    ipcalc # Simple IP network calculator
    bind # Domain name server
    nftables # The project that aims to replace the existing {ip,ip6,arp,eb}tables framework
    networkmanager # Network configuration and management tool
    dhcpcd # A client for the Dynamic Host Configuration Protocol (DHCP)
    dhcping # Send DHCP request to find out if a DHCP server is running
    dnsmasq # An integrated DNS, DHCP and TFTP server for small networks
    # firewalld # Firewall daemon with D-Bus interface
    firewalld-gui # Firewall daemon with D-Bus interface
    hostapd # A user space daemon for access point and authentication servers
    iproute2 # A collection of utilities for controlling TCP/IP networking and traffic control in Linux
    # iptables # A program to configure the Linux IP packet filtering ruleset
    iptables-legacy # A program to configure the Linux IP packet filtering ruleset
    iwd # Wireless daemon for Linux
    iw # Tool to use nl80211
    networkd-dispatcher # Dispatcher service for systemd-networkd connection status changes
    routedns # DNS stub resolver, proxy and router
    trust-dns # A Rust based DNS client, server, and resolver
    mtr # A network diagnostics tool
    ethtool # Utility for controlling network drivers and hardware
    nettools # A set of tools for controlling the network subsystem in Linux
  ];
}