{
  settings,
  lib,
  config,
  pkgs,
  ...
}:

let
  kernel = config.boot.kernelPackages.kernel;

  # Out-of-tree RealTek RTL8188EUS driver with monitor mode and packet injection support,
  # updated for modern Linux kernels (up to 7.x) and compiled with Clang/LTO compatibility.
  rtl8188eus = config.boot.kernelPackages.rtl8188eus-aircrack.overrideAttrs (old: {
    pname = "rtl8188eus-aircrack";
    src = pkgs.fetchFromGitHub {
      owner = "gglluukk";
      repo = "rtl8188eus";
      rev = "f48878a7a66b1281e6eab0cf2b55e7149510daf2";
      hash = "sha256-uothRY0G4FFKYDDhzoHTWnlLcuULBNWOz22Bps7yujw=";
    };
    meta = old.meta // { broken = false; };
    makeFlags = (old.makeFlags or [ ]) ++ kernel.commonMakeFlags ++ [
      "USER_EXTRA_CFLAGS=-Wno-unknown-warning-option -Wno-error"
    ];
    postPatch = (old.postPatch or "") + ''
      substituteInPlace Makefile \
        --replace-quiet "-Wno-restrict" "" \
        --replace-quiet "-Wno-vla-larger-than" ""
    '';
  });
in
lib.mkIf (settings.modules.networking.wifi or false) {
  # Add the out-of-tree 8188eu kernel module
  boot.extraModulePackages = [ rtl8188eus ];

  # Blacklist conflicting in-tree kernel drivers
  boot.blacklistedKernelModules = [
    "rtl8xxxu"
    "r8188eu"
  ];

  # Disable power saving and USB autosuspend on 8188eu for reliable monitor mode and injection
  boot.extraModprobeConfig = ''
    options 8188eu rtw_power_mgnt=0 rtw_enusbss=0
  '';
  # ===============================================
  # NetworkManager configuration
  # ===============================================
  networking.networkmanager = {
    # Keep NetworkManager from interfering with wlan0 during testing tools (wifite, hcxdumptool).
    # Match both interface-name and permanent MAC so NM does not reclaim the interface
    # if its MAC address is randomized or changed by testing tools.
    unmanaged = [
      "interface-name:wlan0"
      "mac:a8:42:a1:1c:e6:27"
    ];

    # Wireless configuration
    wifi = {
      # Disable WiFi power saving globally to avoid drops and packet loss
      powersave = false;
      scanRandMacAddress = false;
      backend = "${settings.modules.networking.wifiBackend}";
    };
  };
}
