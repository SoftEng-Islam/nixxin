{ settings, pkgs, ... }:
let
  enable_android_development_stuff =
    if settings.system.features.android.development_stuff then
      [ ./development.nix ]
    else
      [ ];
  enable_android_studio =
    if settings.system.features.android.android_studio then
      [ ./android-studio.nix ]
    else
      [ ];
in {
  imports = enable_android_development_stuff ++ enable_android_studio
    ++ [ ./scrcpy.nix ./waydroid.nix ];
  programs.adb.enable = true;
  environment.systemPackages = with pkgs;
    [
      # Display and control Android devices over USB or TCP/IP
      android-tools
    ];
}
