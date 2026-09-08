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
    # This kernel is a Clang/LTO build (see -fsplit-lto-unit,
    # -mretpoline-external-thunk in the kernel's baked-in CFLAGS) — an
    # out-of-tree module has to be built with the same toolchain.
    # kernel.moduleBuildDependencies (already in nativeBuildInputs via the
    # base package) should already carry the matching clang; LLVM=1 just
    # tells kbuild to reach for it instead of defaulting to "gcc".
    makeFlags = (old.makeFlags or [ ]) ++ [ "LLVM=1" ];
    # Serialize the build (base package sets this true) so a compile
    # error shows up as one clean message instead of several files'
    # output interleaved together in the log.
    enableParallelBuilding = false;
    # The driver's own headers (drv_types.h etc.) live in ./include —
    # whatever this fork's Makefile does to add that to the search path
    # isn't working under the LLVM build, so add it directly.
    preBuild = (old.preBuild or "") + ''
      export NIX_CFLAGS_COMPILE="$NIX_CFLAGS_COMPILE -I$PWD/include"
    '';
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
