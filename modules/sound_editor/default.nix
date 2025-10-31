{ settings, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  _pkgs = with pkgs;
    [ (lib.optional settings.modules.sound_editor.audacity audacity) ];
in mkIf (settings.modules.sound_editor.enable or false) {
  environment.systemPackages = lib.flatten _pkgs;
}
