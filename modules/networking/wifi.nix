{
  settings,
  lib,
  config,
  pkgs,
  ...
}:

lib.mkIf (settings.modules.networking.rtl8xxxu or false) {
  # Prevent the old staging driver from conflicting with rtl8xxxu
  boot.blacklistedKernelModules = [ "r8188eu" ];

  # ===============================================
  # NetworkManager configuration
  # ===============================================
  networking.networkmanager = {
    # [keyfile]
    # To get The MAC Address run this Command:
    # nmcli device show [wifiInterface] | grep HWADDR
    keyfile."unmanaged-devices" = "mac:A8:42:A1:1C:E6:27";

    # Make NetworkManager ignore your specific TP-Link adapter
    unmanaged = [ "mac:a8:42:a1:1c:e6:27" ];

    # Disable WiFi power saving globally

    # Wireless configuration
    # Using IWD (iNet Wireless Daemon) instead of WPA Supplicant for:
    # - WPA2, WPA3, and Enterprise authentication.
    # - Improved performance and resource usage.
    # - Integration with NetworkManager/systemd-networkd.
    # "wpa_supplicant" or "iwd"
    wifi = {
      powersave = false;
      scanRandMacAddress = false;
      macAddress = "CE:CD:2A:8C:8D:B3";
      backend = "${settings.modules.networking.wifiBackend}";
    };
    settings = {
      # [keyfile]
      # To get The MAC Address run this Command:
      # nmcli device show [wifiInterface] | grep HWADDR
      keyfile."unmanaged-devices" = "mac:A8:42:A1:1C:E6:27";
  };
}
