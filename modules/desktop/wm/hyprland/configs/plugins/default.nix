{ settings, lib, pkgs, ... }:
let
  _hyprPlugins = [
    (lib.optional settings.hyprland.plugins.bordersPlus ./borders-plus.nix)
    (lib.optional settings.hyprland.plugins.hyprbars ./hyprbars.nix)
    (lib.optional settings.hyprland.plugins.hyprexpo ./hyprexpo.nix)
    (lib.optional settings.hyprland.plugins.hyprspace ./hyprspace.nix)
    (lib.optional settings.hyprland.plugins.hyprtrails ./hyprtrails.nix)
  ];
in { imports = lib.flatten _hyprPlugins; }
