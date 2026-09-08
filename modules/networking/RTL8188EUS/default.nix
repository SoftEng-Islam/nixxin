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
let
  rtl8188eus-fixed = config.boot.kernelPackages.rtl8188eus-aircrack.overrideAttrs (old: {
    # nixpkgs has this marked broken at the rev this flake is pinned to;
    # the sed below is what actually fixes the build (GCC 14 doesn't know
    # the clang-only -Wno-sometimes-uninitialized flag the driver's
    # Makefile passes it), so it's safe to just clear the flag here.
    meta = old.meta // {
      broken = false;
    };
    # The kernel is built with Clang, but this driver's Makefile calls
    # `gcc` directly instead of respecting the kernel's $(CC)/LLVM setting.
    # gcc in environment.systemPackages doesn't reach this sandboxed
    # build, so it has to go in nativeBuildInputs instead.
    nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ pkgs.gcc ];
    postPatch = (old.postPatch or "") + ''
      sed -i 's/-Wno-sometimes-uninitialized//' Makefile
    '';
  });
in
lib.mkIf (settings.modules.networking.rtl8188eus or false) {
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

  boot.extraModulePackages = [ rtl8188eus-fixed ];

  # Install the patched rtl8188eus driver (supports monitor mode)
  # boot.extraModulePackages = with config.boot.kernelPackages; [
  #   (callPackage ./package.nix { })
  # ];

  boot.kernelModules = [ "8188eu" ];

  # Optional: Disable idle power saving for better WiFi stability
  boot.extraModprobeConfig = ''
    options 8188eu rtw_ips_mode=0 rtw_power_mgnt=0 rtw_enusbss=0
  '';

  # The Required Packages
  environment.systemPackages = with pkgs; [
    gcc
  ];
}
