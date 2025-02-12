{ settings, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  _pkgs = with pkgs;
    [
      (lib.optional settings.modules.apps.sound_editor.audacity.enable audacity)
    ];
in mkIf (settings.modules.apps.sound_editor.enable) {
  environment.systemPackages = lib.flatten _pkgs;
}
