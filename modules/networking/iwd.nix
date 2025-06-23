{ settings, lib, pkgs, ... }: {

  # Wireless configuration
  # Using IWD (iNet Wireless Daemon) instead of WPA Supplicant for:
  # - WPA2, WPA3, and Enterprise authentication.
  # - Improved performance and resource usage.
  # - Integration with NetworkManager/systemd-networkd.
  networking.networkmanager = {
    wifi = {
      backend = "iwd"; # "wpa_supplicant" or "iwd"
    };
  };
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
        NameResolvingService = "none";
      };
      # MAC address randomization
      General = {
        UseDefaultInterface = true;
        AddressRandomization = "once";
        AddressRandomizationRange = "full";
        EnableNetworkConfiguration = true;
      };
      DriverQuirks.UseDefaultInterface = true;
      Settings.AutoConnect = true;
    };
  };
  environment.systemPackages = with pkgs; [ impala iwd ];
}
