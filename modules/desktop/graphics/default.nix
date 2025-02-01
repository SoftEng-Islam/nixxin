# ---- Graphics Apps ----#
{ settings, lib, pkgs, ... }:
let
  # Free design software that keeps your flow with AI tools and built-in graphics
  lunacyApp = lib.optional settings.graphics.lunacy pkgs.lunacy;
  # Unofficial Electron-based Figma desktop app for Linux
  figmaApp = lib.optional settings.graphics.figmaLinux pkgs.figma-linux;
  # A desktop application for creating diagrams
  drawioApp = lib.optional settings.graphics.drawio pkgs.drawio;
  # 3D Creation/Animation/Publishing System
  blenderApp = lib.optional settings.graphics.blender pkgs.blender-hip;
  # GNU Image Manipulation Program
  gimpApp = lib.optional settings.graphics.gimp pkgs.gimp;
  # Vector graphics editor
  inkscapeApp = lib.optional settings.graphics.inkscape pkgs.inkscape;
  # Virtual lighttable and darkroom for photographers
  darktableApp = lib.optional settings.graphics.darktable pkgs.darktable;
in {
  environment.systemPackages = [
    lunacyApp
    figmaApp
    drawioApp
    blenderApp
    gimpApp
    inkscapeApp
    darktableApp
  ];
}
