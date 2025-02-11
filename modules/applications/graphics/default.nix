# ---- Graphics Apps ----#
{ settings, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  graphicsApps = with pkgs; [
    (lib.optional settings.modules.graphics.lunacy.enable lunacy)
    (lib.optional settings.modules.graphics.figmaLinux.enable figma-linux)
    (lib.optional settings.modules.graphics.drawio.enable drawio)
    (lib.optional settings.modules.graphics.blender.enable blender)
    (lib.optional settings.modules.graphics.gimp.enable gimp)
    (lib.optional settings.modules.graphics.inkscape.enable inkscape)
    (lib.optional settings.modules.graphics.darktable.enable darktable)
  ];
in mkIf (settings.modules.graphics.enable) {
  environment.systemPackages = lib.flatten graphicsApps;
}
