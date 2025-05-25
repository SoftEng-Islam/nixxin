{ config, pkgs, ... }:

{
  # Blacklist conflicting drivers
  boot.blacklistedKernelModules = [ "rtl8xxxu" "r8188eu" ];

  # Install the patched rtl8188eus driver (supports monitor mode)
  boot.extraModulePackages = with pkgs;
    [ linuxKernel.packages.linux_6_13_hardened.rtl8188eus-aircrack ];

  boot.kernelModules = [ "8188eu" ];

  # Optional: Disable power saving for better WiFi stability
  boot.kernelParams = [ "rtl8188eus.ips_mode=0" ];

  # Optional: Enable Aircrack-NG tools
  environment.systemPackages = with pkgs;
    [ linuxKernel.packages.linux_6_13_hardened.rtl8188eus-aircrack ];

}
