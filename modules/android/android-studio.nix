{ settings, lib, pkgs, ... }:
lib.mkIf (settings.modules.android.android_studio.enable or false) {
  environment.systemPackages = with pkgs;
    [
      # Official IDE for Android (stable channel)
      android-studio
    ];
}
