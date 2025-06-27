{ settings, lib, pkgs, ... }:
lib.mkIf (settings.modules.networking.iwd or true) {
  # give wireless cards time to turn on
  systemd.services.iwd.serviceConfig.ExecStartPre =
    "${pkgs.coreutils}/bin/sleep 2";

  networking.wireless.iwd = {
    # Example commands manage Wi-Fi connections:
    #- iwctl
    #-- device list             # List wireless devices
    #-- station wlan0 scan      # Scan for networks
    #-- station wlan0 get-networks  # Show available networks
    #-- station wlan0 connect SSID  # Connect to a network
    enable = settings.modules.networking.iwd;
    settings = {
      Network = {
        EnableIPv6 = true;
        RoutePriorityOffset = 300;
        NameResolvingService = "none";
      };
      # MAC address randomization
      General = {
        AddressRandomization = "once";
        AddressRandomizationRange = "full";
        EnableNetworkConfiguration = true;
        # attempt to find a better AP every 10 seconds (default is 60)
        RoamRetryInterval = "10";
      };
      DriverQuirks.UseDefaultInterface = true;
      Settings.AutoConnect = true;
    };
  };
  environment.systemPackages = with pkgs; [ impala iwd ];
}
