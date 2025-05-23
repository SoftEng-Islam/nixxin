{ settings, lib, pkgs, ... }: {
  systemd.network.wait-online.enable = false;
  boot.initrd.systemd.network.wait-online.enable = false;
  networking = {
    # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
    # (the default) this is the recommended approach. When using systemd-networkd it's
    # still possible to use this option, but it's recommended to use it in conjunction
    # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
    useDHCP = lib.mkDefault false;

    # interfaces.eno1.useDHCP = lib.mkDefault true;
    # interfaces.wlp0s16f1u2.useDHCP = lib.mkDefault true;

    interfaces.enp4s0.useDHCP = lib.mkDefault false;
    interfaces.wlp0s22f2u4.useDHCP = lib.mkDefault true;

    # interfaces.enp3s0.useDHCP = false;
    # interfaces.enp3s0.ipv4.addresses = [{
    #   address = "192.168.69.1";
    #   prefixLength = 24;
    # }];

    networkmanager = {
      enable = true;
      wifi.powersave = false;
      # dns = "none"; # "none" or "dnsmasq"
      # increase boot speed
      # wifi.backend = "wpa_supplicant"; # "wpa_supplicant" or "iwd"
    };

    nat = {
      enable = true;
      internalInterfaces = [ "enp4s0" ];
      externalInterface = "wlp0s22f2u4";
    };

    hostName = settings.system.hostName; # Define your hostname.
    nftables.enable = true;
    dhcpcd.enable = false;
    useNetworkd = false;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 53 80 443 8080 3389 ];
      allowedUDPPorts = [ 53 67 ];
    };

    nameservers = settings.modules.networking.nameservers;

    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~
    # ~~~~ Wireless Settings ~~~~
    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~
    # If your system only uses a wired Ethernet connection, you can disable wireless support to simplify your configuration and save resources.
    wireless.enable = false; # Default false # wpa_supplicant.

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
      enable = false;
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
    resolved.enable =
      if (settings.modules.networking.dnsResolver == "systemd-resolved") then
        true
      else
        false; # Systemd DNS Resolver Daemon, systemd-resolved.
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
    wpa_supplicant
    wpa_supplicant_gui
    sipcalc # Advanced console ip subnet calculator
    iperf # Tool to measure IP bandwidth using UDP or TCP
    netcat # Free TLS/SSL implementation
    mtr # Network diagnostics tool
    tcpdump # Network sniffer
    bandwhich # CLI utility for displaying current network utilization
    dnsutils # Domain name server
    avahi # mDNS/DNS-SD implementation

    ntp # An implementation of the Network Time Protocol
    openresolv # A program to manage /etc/resolv.conf
    radvd # IPv6 Router Advertisement Daemon
    tcpdump # Network sniffer
    nssmdns # The mDNS Name Service Switch (NSS) plug-in
    nmap # A free and open source utility for network discovery and security auditing
    networkmanager # Network configuration and management tool
    networkmanagerapplet # NetworkManager control applet for GNOME
    networkmanager-openconnect # NetworkManager’s OpenConnect plugin
    wirelesstools # Wireless tools for Linux
    inetutils # Collection of common network programs
    ipset # Administration tool for IP sets
    ipcalc # Simple IP network calculator
    bind # Domain name server
    nftables # The project that aims to replace the existing {ip,ip6,arp,eb}tables framework
    dhcpcd # A client for the Dynamic Host Configuration Protocol (DHCP)
    dhcping # Send DHCP request to find out if a DHCP server is running
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

    iftop # network monitoring
  ];

}
