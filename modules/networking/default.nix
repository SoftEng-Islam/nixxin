{ settings, lib, pkgs, ... }:
let
  dnsResolver = settings.modules.networking.dnsResolver;
  wifiInterface = "wlp0s19f2u5";
in {
  imports =
    [ ./dnsmasq.nix ./iwd.nix ./RTL8188EUS.nix ./rtw.nix ./waypipe.nix ];

  boot.initrd.systemd.network.wait-online.enable = false;

  systemd.network.enable = true;
  systemd.network.wait-online.enable = false;
  systemd.network.wait-online.timeout = 0;
  systemd.network.wait-online.anyInterface = false;

  services.avahi.enable = true;
  services.avahi.publish.enable = true;
  services.avahi.publish.userServices = true;

  services.hostapd.enable = false;
  services.networkd-dispatcher.enable = true;

  services.resolved.enable = if (dnsResolver == "systemd-resolved") then
    true
  else
    false; # Systemd DNS Resolver Daemon, systemd-resolved.

  networking = {
    # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
    # (the default) this is the recommended approach. When using systemd-networkd it's
    # still possible to use this option, but it's recommended to use it in conjunction
    # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
    useDHCP = lib.mkDefault true;
    # interfaces.[interface].useDHCP = lib.mkDefault true;
    nameservers = settings.modules.networking.nameservers;

    hostName = settings.system.hostName; # Define your hostname.
    dhcpcd.enable = false;
    useNetworkd = true;

    interfaces.enp4s0 = {
      useDHCP = false; # Disable DHCP (so no default route or DNS is set)
      ipv4.addresses = [{
        # sudo ip addr flush dev enp4s0
        # sudo ip addr add 192.168.10.2/24 dev enp4s0
        address = "192.168.10.1"; # Set static IP for local RDP
        prefixLength = 24;
      }];
    };

    # defaultGateway = "192.168.1.1";

    # ip route | grep default
    # nmcli device show wlan0 | grep IP4.GATEWAY
    # defaultGateway = {
    # interface = "wlp0s22f2u4";
    # address = "192.168.2.1"; # e.g., 192.168.1.1
    # };

    # nat = {
    #   enable = true;
    #   internalInterfaces = [ "enp4s0" ];
    #   externalInterface = "wlp0s22f2u4";
    # };

    # extraHosts = ''
    #   127.0.0.1 softeng.home
    # '';
    hosts = {
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
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 53 80 443 8080 3389 ];
    allowedUDPPorts = [ 53 67 ];
  };

  networking.nftables = {
    enable = true;
    ruleset = ''
      table ip nat {
        chain postrouting {
          type nat hook postrouting priority 100;
          oifname "${wifiInterface}" masquerade
        }
      }
      table ip filter {
        chain forward {
          type filter hook forward priority 0;
          iifname "enp4s0" oifname "${wifiInterface}" accept
          iifname "${wifiInterface}" oifname "enp4s0" ct state related,established accept
        }
      }
    '';
  };

  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # ~~~~ Wireless Settings ~~~~
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # If your system only uses a wired Ethernet connection, you can disable wireless support to simplify your configuration and save resources.
  # disable wpa_supplicant, we have networkmanager and iwd
  # You can not use networking.networkmanager with networking.wireless.
  networking.wireless = {
    enable = false;
    scanOnLowSignal = false;
  };

  networking.networkmanager = {
    enable = settings.modules.networking.networkManager;
    logLevel = "OFF";
    dhcp = "internal"; # one of "dhcpcd", "internal"
    # $ bat /etc/NetworkManager/NetworkManager.conf
    settings = {
      # [device]
      device."wifi.scan-rand-mac-address" = "no";

      # Wireless configuration
      # Using IWD (iNet Wireless Daemon) instead of WPA Supplicant for:
      # - WPA2, WPA3, and Enterprise authentication.
      # - Improved performance and resource usage.
      # - Integration with NetworkManager/systemd-networkd.
      # "wpa_supplicant" or "iwd"
      device."wifi.backend" = "${settings.modules.networking.wifiBackend}";

      # [ifupdown]
      # ifupdown."managed" = "true";

      # [connection]
      connection = {
        "wifi.powersave" = "0";
        # "connection.llmnr" = 2; # Disable LLMNR
        # "connection.mdns" = 2; # Disable mDNS
        # "wifi.cloned-mac-address" = "stable";
        # "ipv6.ipv6-privacy" = "2";
      };

      # [main]
      main."plugins" = "keyfile";
      #main."dhcp" = "internal";
      #main."dns" = "systemd-resolved";
      #main."rc-manager" = "unmanaged";

      # [keyfile]
      # To get The MAC Address run this Command:
      # nmcli device show [wifiInterface] | grep HWADDR
      # keyfile."unmanaged-devices" = "mac:CA:B5:C5:97:AD:C4";

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

  # environment.etc."NetworkManager/system-connections".source =
  #   "/var/lib/NetworkManager/system-connections";

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

  # environment.etc."NetworkManager/conf.d/wifi_rand_mac.conf" = {
  #   text = ''
  #     [device-mac-randomization]
  #     # "yes" is already the default for scanning
  #     wifi.scan-rand-mac-address=yes

  #     [connection-mac-randomization]
  #     # Randomize MAC for every ethernet connection
  #     #ethernet.cloned-mac-address=random
  #     # Generate a random MAC ethernet connection
  #     ethernet.cloned-mac-address=stable
  #     # Generate a randomized value upon each connection
  #     #wifi.cloned-mac-address=random
  #     # Generate a random MAC for each WiFi and associate the two permanently
  #     wifi.cloned-mac-address=stable
  #   '';
  #   mode = "0400";
  # };

  # the default backend is "wpa_supplicant".
  # wpa_supplicant reliably picks weak APs to connect to.
  # see: <https://gitlab.freedesktop.org/NetworkManager/NetworkManager/-/issues/474>
  # iwd is an alternative that shouldn't have this problem
  # docs:
  # - <https://wiki.archlinux.org/title/Iwd>
  # - <https://nixos.wiki/wiki/Iwd>
  # - <https://iwd.wiki.kernel.org/networkmanager>
  # - `man iwd.config`  for global config
  # - `man iwd.network` for per-SSID config
  # use `iwctl` to control
  # networking.networkmanager.wifi.backend = "iwd";
  # networking.wireless.iwd.enable = true;
  # networking.wireless.iwd.settings = {
  #   # auto-connect to a stronger network if signal drops below this value
  #   # bedroom -> bedroom connection is -35 to -40 dBm
  #   # bedroom -> living room connection is -60 dBm
  #   General.RoamThreshold = "-52";  # default -70
  #   General.RoamThreshold5G = "-52";  # default -76
  # };

  # allow networkmanager to control systemd-resolved,
  # which it needs to do to apply new DNS settings when using systemd-resolved.
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (subject.isInGroup("networkmanager") && action.id.indexOf("org.freedesktop.resolve1.") == 0) {
        return polkit.Result.YES;
      }
    });
  '';

  environment.variables = {
    #? What is GIO_EXTRA_MODULES?
    #* It’s an environment variable used by GIO, a core part of the GLib/GTK stack.
    #>> GIO provides things like:
    #>> File system abstraction (opening FTP, HTTP, Google Drive, etc.)
    #>> Network file access
    #>> GVfs (GNOME Virtual file system)
    #>> Proxy support
    #>> TLS support
    # GIO_EXTRA_MODULES = with pkgs; [ "${glib-networking}/lib/gio/modules" ];
    #! error: The option `environment.variables.GIO_EXTRA_MODULES' is defined multiple times while it's expected to be unique.
  };

  # environment.etc."resolv.conf".text = "nameserver 8.8.8.8";
  environment.systemPackages = with pkgs; [
    wpa_supplicant
    wpa_supplicant_gui

    networkmanager
    networkmanagerapplet
    ifwifi

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

    wirelesstools # Wireless tools for Linux
    inetutils # Collection of common network programs
    ipset # Administration tool for IP sets
    ipcalc # Simple IP network calculator
    bind # Domain name server
    nftables # The project that aims to replace the existing {ip,ip6,arp,eb}tables framework
    dhcpcd # A client for the Dynamic Host Configuration Protocol (DHCP)
    dhcping # Send DHCP request to find out if a DHCP server is running

    # firewalld # Firewall daemon with D-Bus interface
    # firewalld-gui # Firewall daemon with D-Bus interface

    hostapd # A user space daemon for access point and authentication servers
    iproute2 # A collection of utilities for controlling TCP/IP networking and traffic control in Linux
    # iptables # A program to configure the Linux IP packet filtering ruleset

    iptables-legacy # A program to configure the Linux IP packet filtering ruleset
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
