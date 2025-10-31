{ settings, config, lib, pkgs, ... }:
lib.mkIf (settings.modules.networking.rtw or false) {

  # Enable rtw88 kernel module
  boot.extraModulePackages = with config.boot.kernelPackages; [ rtw88 ];

  # Blacklist conflicting drivers (if needed)
  # boot.blacklistedKernelModules = [ "rtl8812au" "rtl8xxxu" "r8188eu" "rtw_8821cu" "rtl8192cu" "rtw_core" ];

  # Enable monitor mode and injection (optional)
  boot.kernelParams = [
    "rtw88.enable_ips=0" # Disable power saving for monitor mode
    "rtw88.disable_msi=1" # Fix issues on some hardware
  ];

  networking.wireless.driver = "rtw_8821cu";

  # environment.systemPackages = with pkgs; [ linuxKernel.packages.linux_zen.rtw88 ];
}
