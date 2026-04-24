{ settings, lib, ... }:
let
  inherit (lib) optional;
  plugins = settings.modules.desktop.hyprland.plugins;
  _hyprPlugins = [
    (optional plugins.bordersPlus ./borders-plus.nix)
    (optional plugins.hyprbars ./hyprbars.nix)
    (optional plugins.hyprexpo ./hyprexpo.nix)
    (optional plugins.hyprspace ./hyprspace.nix)
    (optional plugins.hyprtrails ./hyprtrails.nix)
  ];
in { imports = lib.flatten _hyprPlugins; }
