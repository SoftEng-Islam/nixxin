{ settings, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  _android = [
    (lib.optional settings.moudles.android.development ./development.nix)
    (lib.optional settings.moudles.android.android_studio ./android-studio.nix)
    (lib.optional settings.moudles.android.scrcpy ./scrcpy.nix)
    (lib.optional settings.moudles.android.waydroid ./waydroid.nix)
  ];
in {
  imports = lib.flatten _android;

  config = mkIf (settings.moudles.android.enable) {
    programs.adb.enable = true;
    environment.systemPackages = with pkgs;
      [
        # Display and control Android devices over USB or TCP/IP
        android-tools
      ];
  };
}
