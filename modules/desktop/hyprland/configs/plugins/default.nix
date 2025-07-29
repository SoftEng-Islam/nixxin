{ settings, lib, pkgs, ... }:
let
  _hyprPlugins = [
    (lib.optional settings.modules.desktop.hyprland.plugins.bordersPlus
      ./borders-plus.nix)
    (lib.optional settings.modules.desktop.hyprland.plugins.hyprbars ./hyprbars.nix)
    (lib.optional settings.modules.desktop.hyprland.plugins.hyprexpo ./hyprexpo.nix)
    (lib.optional settings.modules.desktop.hyprland.plugins.hyprspace ./hyprspace.nix)
    (lib.optional settings.modules.desktop.hyprland.plugins.hyprtrails ./hyprtrails.nix)
  ];
in { imports = lib.flatten _hyprPlugins; }
