{ settings, lib, pkgs, ... }:
let
  inherit (lib) optionals optional;
  _graphics_pkgs = settings.modules.graphics;
  _graphics = with pkgs; [
    (optional _graphics_pkgs.blender blender)
    (optional _graphics_pkgs.darktable darktable)
    (optional _graphics_pkgs.drawio drawio)
    (optional _graphics_pkgs.figmaLinux figma-linux)
    (optional _graphics_pkgs.gimp gimp)
    (optional _graphics_pkgs.inkscape inkscape)
    (optional _graphics_pkgs.lunacy lunacy)
    (optional _graphics_pkgs.kolourpaint kolourpaint)
  ];
in {
  imports = optionals (settings.modules.graphics.enable or true) [
    ./mesa.nix
    ./vulkan.nix
  ];
  config = lib.mkIf (settings.modules.graphics.enable or true) {
    environment.systemPackages = lib.flatten _graphics;
  };
}
