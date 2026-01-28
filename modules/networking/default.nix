{ settings, lib, pkgs, ... }:
let
  inherit (lib) mkDefault mkForce;
  dnsResolver = settings.modules.networking.dnsResolver;
  wifiInterface = "wlan0";
in {
  imports =
    [ ./dnsmasq.nix ./iwd.nix ./RTL8188EUS.nix ./rtw.nix ./waypipe.nix ./blocky.nix];

  # Disable waiting for network.
  boot.initrd.systemd.network.wait-online.enable = false;
  systemd.network.enable = lib.mkForce false;
  systemd.network.wait-online.enable = false;
  systemd.network.wait-online.timeout = 0;
  systemd.network.wait-online.anyInterface = false;
  systemd.services.NetworkManager-wait-online.enable = false;

  services.hostapd.enable = false;
  services.networkd-dispatcher.enable = false;

  # Systemd DNS Resolver Daemon, systemd-resolved.
  services.resolved = {
    enable = mkDefault (dnsResolver == "resolved");
    dnssec = "allow-downgrade";
    domains = [ "~." ];
    fallbackDns = settings.modules.networking.nameservers;
    extraConfig = ''
      DNSOverTLS=yes
    '';
  };

  networking.firewall.allowPing = mkDefault false;
  networking.firewall.logRefusedConnections = mkDefault false;

  # Use DHCP for all interfaces by default.
  networking.useDHCP = mkDefault true;
  # networking.interfaces.[interface].useDHCP = lib.mkDefault true;

  networking.dhcpcd.enable = true;
  networking.useNetworkd = mkDefault false;
  networking.nameservers = settings.modules.networking.nameservers;
  networking.hostName = settings.system.hostName; # Define your hostname.
  networking.interfaces = settings.modules.networking.interfaces;

  networking = {

    # defaultGateway = "192.168.1.1";

    # ip route | grep default
    # nmcli device show wlan0 | grep IP4.GATEWAY
    # defaultGateway = {
    #   interface = "wlp0s22f2u4";
    #   address = "192.168.2.1"; # e.g., 192.168.1.1
    # };

    # nat = {
    #   enable = true;
    #   internalInterfaces = [ "enp4s0" ];
    #   externalInterface = "wlp0s22f2u4";
    # };

    # extraHosts = ''
    #   127.0.0.1 softeng.home
    # '';

    # hosts = {
    #    "0.0.0.0" = [
    #      "ex.com"
    #    ];
    # };
  };

  networking.firewall.enable = settings.modules.networking.firewall.enable;
  networking.firewall.allowedTCPPorts =
    [ 53 80 443 8080 3389 51820 27018 3000 ];
  networking.firewall.allowedUDPPorts = [ 53 67 51820 1194 ];
  # networking.firewall.extraCommands = ''
  #   # Block everything except wg0
  #   iptables -I OUTPUT ! -o wg0 -m conntrack --ctstate NEW -j DROP
  # '';

  # Allow ephemeral ranges for better peer discovery in torrent clients
  networking.firewall.allowedTCPPortRanges = [{
    from = 49152;
    to = 65535;
  } # Ephemeral range for torrents
    ];
  networking.firewall.allowedUDPPortRanges = [{
    from = 49152;
    to = 65535;
  }];

  services.miniupnpd = {
    enable = false;
    externalInterface = "wlan0"; # WAN side
    internalIPs = [ "wlan0" ]; # LAN side (must be iface name, not CIDR)
    natpmp = true; # also enable NAT-PMP alongside UPnP
  };

  # Use nftables instead of iptables
  networking.nftables.enable = settings.modules.networking.nftables.enable;
  networking.nftables = {
    # ruleset = ''
    #   table ip nat {
    #     chain postrouting {
    #       type nat hook postrouting priority 100;
    #       oifname "${wifiInterface}" masquerade
    #     }
    #   }
    #   table ip filter {
    #     chain forward {
    #       type filter hook forward priority 0;
    #       iifname "enp4s0" oifname "${wifiInterface}" accept
    #       iifname "${wifiInterface}" oifname "enp4s0" ct state related,established accept
    #     }
    #   }
    # '';
  };

  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # ~~~~ Wireless Settings ~~~~
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # If your system only uses a wired Ethernet connection, you can disable wireless support to simplify your configuration and save resources.
  # You can not use networking.networkmanager with networking.wireless.
  networking.wireless.enable = lib.mkForce false;
  networking.wireless.scanOnLowSignal = false;
  networking.wireless.userControlled.enable = true;

  networking.networkmanager = {
    enable = true;
    logLevel = "OFF";
    dhcp = "dhcpcd"; # one of "dhcpcd", "internal"
    # $ bat /etc/NetworkManager/NetworkManager.conf
    settings = {
      # [device]
      # "yes" is already the default for scanning
      device."wifi.scan-rand-mac-address" = "yes";

      # Wireless configuration
      # Using IWD (iNet Wireless Daemon) instead of WPA Supplicant for:
      # - WPA2, WPA3, and Enterprise authentication.
      # - Improved performance and resource usage.
      # - Integration with NetworkManager/systemd-networkd.
      # "wpa_supplicant" or "iwd"
      device."wifi.backend" = "${settings.modules.networking.wifiBackend}";

      # [ifupdown]
      ifupdown."managed" = "true";

      # [connection]
      connection = {
        "wifi.powersave" = "0";
        # "connection.llmnr" = 2; # Disable LLMNR
        # "connection.mdns" = 2; # Disable mDNS
        # "ipv6.ipv6-privacy" = "2";

        # Randomize MAC for every ethernet connection
        # ethernet.cloned-mac-address=random

        # Generate a random MAC ethernet connection
        "ethernet.cloned-mac-address" = "stable";

        # Generate a randomized value upon each connection
        #wifi.cloned-mac-address=random

        # Generate a random MAC for each WiFi and associate the two permanently
        "wifi.cloned-mac-address" = "stable";
      };

      # [main]
      main."plugins" = "keyfile";
      main."dhcp" = "internal";
      main."dns" = "systemd-resolved";
      main."rc-manager" = "unmanaged";

      # [keyfile]
      # To get The MAC Address run this Command:
      # nmcli device show [wifiInterface] | grep HWADDR
      # keyfile."unmanaged-devices" = "mac:A8:42:A1:1C:E6:27";

      # [logging]
      # logging."audit" = "false"; # < default
      # logging."level" = "OFF";
    };

    # wifi.macAddress = "CE:CD:2A:8C:8D:B3";
    # wifi.powersave = false;
    # wifi.scanRandMacAddress = false;

    # dns = "none"; # "none" or "dnsmasq"
    ethernet = { macAddress = "preserve"; };
  };

  # Wifi PowerManagement
  # environment.etc."NetworkManager/conf.d/99-wifi-no-powersave.conf".text = ''
  #   [connection]
  #   wifi.powersave = 2
  #   wifi.cloned-mac-address = preserve
  #   ethernet.cloned-mac-address = preserve

  #   [device]
  #   wifi.backend = iwd
  #   wifi.scan-rand-mac-address = false
  # '';

  # allow networkmanager to control systemd-resolved,
  # which it needs to do to apply new DNS settings when using systemd-resolved.
  # security.polkit.extraConfig = ''
  # polkit.addRule(function(action, subject) {
  # if (subject.isInGroup("networkmanager") && action.id.indexOf("org.freedesktop.resolve1.") == 0) {
  # return polkit.Result.YES;
  # }
  # });
  # '';

  environment.variables = {
    NEWT_COLORS = ''
      root=white,#0f0a14
      border=#cba6f7,#1a1524
      window=white,#1a1524
      shadow=black,#0a0610
      title=#f5c2e7,#1a1524
      label=white,#1a1524
      listbox=white,#221b2e
      actlistbox=black,#cba6f7
      helpline=black,#f38ba8
      button=black,#cba6f7
      actbutton=white,#f38ba8
      checkbox=white,#1a1524
      actcheckbox=black,#cba6f7
      entry=white,#2a213a
      textbox=white,#1a1524
      acttextbox=black,#f38ba8
      roottext=#cba6f7,#0f0a14
      disentry=gray,#1a1524
      actsellistbox=black,#f38ba8
      sellistbox=white,#221b2e
    '';
  };

  environment.systemPackages = with pkgs; [
    wpa_supplicant
    wpa_supplicant_gui

    networkmanager
    ifwifi

    sipcalc # Advanced console ip subnet calculator
    iperf # Tool to measure IP bandwidth using UDP or TCP
    netcat # Free TLS/SSL implementation
    mtr # Network diagnostics tool
    tcpdump # Network sniffer
    bandwhich # CLI utility for displaying current network utilization
    dnsutils # Domain name server

    openresolv # A program to manage /etc/resolv.conf
    radvd # IPv6 Router Advertisement Daemon
    tcpdump # Network sniffer
    nmap # A free and open source utility for network discovery and security auditing

    inetutils # Collection of common network programs
    ipset # Administration tool for IP sets
    ipcalc # Simple IP network calculator
    bind # Domain name server
    dhcpcd # A client for the Dynamic Host Configuration Protocol (DHCP)
    dhcping # Send DHCP request to find out if a DHCP server is running

    # firewalld # Firewall daemon with D-Bus interface
    firewalld-gui # Firewall daemon with D-Bus interface

    hostapd # A user space daemon for access point and authentication servers
    iproute2 # A collection of utilities for controlling TCP/IP networking and traffic control in Linux

    nftables # The project that aims to replace the existing {ip,ip6,arp,eb}tables framework
    # iptables # A program to configure the Linux IP packet filtering ruleset
    # iptables-legacy # A program to configure the Linux IP packet filtering ruleset

    iw # Tool to use nl80211
    networkd-dispatcher # Dispatcher service for systemd-networkd connection status changes
    routedns # DNS stub resolver, proxy and router
    hickory-dns # A Rust based DNS client, server, and resolver
    mtr # A network diagnostics tool
    ethtool # Utility for controlling network drivers and hardware
    nettools # A set of tools for controlling the network subsystem in Linux

    iftop # network monitoring
  ];
}
