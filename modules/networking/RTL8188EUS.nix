{ settings, lib, config, pkgs, ... }:
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

lib.mkIf (settings.modules.networking.rtl8188eus-aircrack or false) {
  # https://github.com/aircrack-ng/rtl8188eus
  # Supports
  # Android 12/13
  # MESH Support
  # Monitor mode
  # Frame injection
  # Up to kernel v6.5+ ... And a bunch of various wifi chipsets
  # Blacklist conflicting drivers
  boot.blacklistedKernelModules = [
    # "rtl8xxxu" # My Default Wifi Driver
    # "r8188eu"
  ];

  # Install the patched rtl8188eus driver (supports monitor mode)
  boot.extraModulePackages = with config.boot.kernelPackages;
    [ (callPackage ./rtl8188eus_custom.nix { }) ];

  boot.kernelModules = [ "8188eu" ];

  # Optional: Disable power saving for better WiFi stability
  boot.kernelParams = [ "rtl8188eus.ips_mode=0" ];

}
