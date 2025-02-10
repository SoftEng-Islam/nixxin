# ---- Graphics Apps ----#
{ settings, lib, pkgs, ... }:
let
  graphicsApps = [
    (lib.optional settings.system.graphics.lunacy pkgs.lunacy)
    (lib.optional settings.system.graphics.figmaLinux pkgs.figma-linux)
    (lib.optional settings.system.graphics.drawio pkgs.drawio)
    (lib.optional settings.system.graphics.blender pkgs.blender)
    (lib.optional settings.system.graphics.gimp pkgs.gimp)
    (lib.optional settings.system.graphics.inkscape pkgs.inkscape)
    (lib.optional settings.system.graphics.darktable pkgs.darktable)
  ];
in { environment.systemPackages = lib.flatten graphicsApps; }
