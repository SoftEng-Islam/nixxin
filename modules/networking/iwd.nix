# https://man.archlinux.org/man/iwd.config.5.en
# https://wiki.archlinux.org/title/Network_configuration/Wireless
# https://wiki.archlinux.org/title/Iwd
{ settings, lib, pkgs, ... }:
lib.mkIf (settings.modules.networking.iwd or false) {
  # give wireless cards time to turn on
  systemd.services.iwd.serviceConfig.ExecStartPre =
    "${pkgs.coreutils}/bin/sleep 2";

  # services.connman.wifi.backend = "iwd";
  networking.wireless.iwd = {
    # Example commands manage Wi-Fi connections:
    #- iwctl
    #-- device list             # List wireless devices
    #-- station wlan0 scan      # Scan for networks
    #-- station wlan0 get-networks  # Show available networks
    #-- station wlan0 connect SSID  # Connect to a network
    enable = settings.modules.networking.iwd;
    # package = pkgs.eiwd;
    settings = {
      Network = {
        # EnableIPv6 = true;
        # RoutePriorityOffset = 300;
        NameResolvingService = "systemd";
      };
      # MAC address randomization
      General = {
        EnableNetworkConfiguration = true;

        # attempt to find a better AP every 10 seconds (default is 60)
        RoamRetryInterval = "600";

        RoamThreshold = "-85";
        Country = "US"; # Set your country code

      };
      Settings.AutoConnect = true;
    };
  };
  environment.systemPackages = with pkgs; [ impala iwd ];
}
