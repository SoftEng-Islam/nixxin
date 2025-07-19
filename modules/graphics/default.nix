{ settings, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  _graphics = with pkgs; [
    (lib.optional settings.modules.graphics.blender blender)
    (lib.optional settings.modules.graphics.darktable darktable)
    # (lib.optional settings.modules.graphics.davinci davinci-resolve)
    (lib.optional settings.modules.graphics.drawio drawio)
    (lib.optional settings.modules.graphics.figmaLinux figma-linux)
    (lib.optional settings.modules.graphics.gimp gimp)
    (lib.optional settings.modules.graphics.inkscape inkscape)
    (lib.optional settings.modules.graphics.lunacy lunacy)
    (lib.optional settings.modules.graphics.kolourpaint kolourpaint)
  ];
in {
  imports = [
    ./mesa.nix
    # ./vulkan.nix
    # ./davinci-resolve.nix
  ];
  config = lib.optionals (settings.modules.graphics.enable) {
    environment.systemPackages = lib.flatten _graphics;
  };
}
