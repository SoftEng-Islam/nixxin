{ settings, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  _android = [
    (lib.optional settings.modules.android.development ./development.nix)
    (lib.optional settings.modules.android.android_studio ./android-studio.nix)
    (lib.optional settings.modules.android.scrcpy ./scrcpy.nix)
    (lib.optional settings.modules.android.waydroid ./waydroid.nix)
  ];
in {
  imports = lib.flatten _android;

  config = mkIf (settings.modules.android.enable) {
    programs.adb.enable = true;
    environment.systemPackages = with pkgs;
      [
        # Display and control Android devices over USB or TCP/IP
        android-tools
      ];
  };
}
