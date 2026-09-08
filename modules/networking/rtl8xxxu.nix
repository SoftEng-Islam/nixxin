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
    # Make NetworkManager ignore your specific TP-Link adapter
    unmanaged = [ "mac:a8:42:a1:1c:e6:27" ];

    # Disable WiFi power saving globally (translates to wifi.powersave=0)
    wifi.powersave = false;

    # Inject the remaining settings directly into NetworkManager.conf
    extraConfig = ''
      [device]
      wifi.scan-rand-mac-address=no

      [ifupdown]
      managed=false
    '';
  };
}
