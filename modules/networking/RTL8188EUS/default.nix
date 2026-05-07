{
  settings,
  lib,
  config,
  pkgs,
  ...
}:
#! ===============================================
#! [IMPORTANT] NetworkManager configuration
#! ===============================================
#* Add these lines below to "NetworkManager.conf" and ADD YOUR ADAPTER MAC below [keyfile] This will make the Network-Manager ignore the device, and therefore don't cause problems.
# =============================
# [device]
# wifi.scan-rand-mac-address=no

# [ifupdown]
# managed=false

# [connection]
# wifi.powersave=0

# [main]
# plugins=keyfile

# [keyfile]
# unmanaged-devices=mac:A7:A7:A7:A7:A7
# =============================

lib.mkIf (settings.modules.networking.rtl8188eus or false) {
  # https://github.com/SimplyCEO/rtl8188eus
  # Supports
  # Android 12/13
  # MESH Support
  # Monitor mode
  # Frame injection
  # Up to kernel 6.17+ ... And a bunch of various wifi chipsets
  # Blacklist conflicting drivers
  boot.blacklistedKernelModules = [
    "rtl8xxxu" # My Default Wifi Driver
    "r8188eu"
  ];

  # Install the patched rtl8188eus driver (supports monitor mode)
  boot.extraModulePackages = with config.boot.kernelPackages; [
    (callPackage ./package.nix { })
  ];

  boot.kernelModules = [ "8188eu" ];

  # Optional: Disable idle power saving for better WiFi stability
  boot.extraModprobeConfig = ''
    options 8188eu rtw_ips_mode=0
  '';

  # The Required Packages
  environment.systemPackages = with pkgs; [
    gcc
  ];
}
