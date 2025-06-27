{ settings, lib, config, pgks, ... }:
lib.mkIf (settings.modules.networking.rtl8188eus-aircrack or false) {
  # Blacklist conflicting drivers
  boot.blacklistedKernelModules = [ "rtl8xxxu" "r8188eu" ];

  # Install the patched rtl8188eus driver (supports monitor mode)
  boot.extraModulePackages = with config.boot.kernelPackages;
    [
      # Aircrack-ng kernel module for Realtek 88XXau network cards (8811au, 8812au, 8814au and 8821au chipsets) with monitor mode and injection support.
      # rtl88xxau-aircrack

      rtl8188eus-aircrack
    ];

  boot.kernelModules = [ "8188eu" ];

  # Optional: Disable power saving for better WiFi stability
  boot.kernelParams = [ "rtl8188eus.ips_mode=0" ];

}
