{ config, pkgs, ... }:

{
  # Blacklist conflicting drivers
  boot.blacklistedKernelModules = [ "rtl8xxxu" "r8188eu" ];

  # Install the patched rtl8188eus driver (supports monitor mode)
  boot.extraModulePackages = with config.boot.kernelPackages;
    [ pkgs.linuxKernel.packages.linux_zen.rtl8188eus-aircrack ];

  # Optional: Enable Aircrack-NG tools
  environment.systemPackages = with pkgs; [ aircrack-ng ];

  # Optional: Disable power saving for better WiFi stability
  boot.kernelParams = [ "rtl8188eus.ips_mode=0" ];
}
