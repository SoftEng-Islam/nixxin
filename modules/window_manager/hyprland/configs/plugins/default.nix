{ settings, lib, pkgs, ... }:
let
  _hyprPlugins = [
    (lib.optional settings.modules.window_manager.hyprland.plugins.bordersPlus
      ./borders-plus.nix)
    (lib.optional settings.modules.window_manager.hyprland.plugins.hyprbars
      ./hyprbars.nix)
    (lib.optional settings.modules.window_manager.hyprland.plugins.hyprexpo
      ./hyprexpo.nix)
    (lib.optional settings.modules.window_manager.hyprland.plugins.hyprspace
      ./hyprspace.nix)
    (lib.optional settings.modules.window_manager.hyprland.plugins.hyprtrails
      ./hyprtrails.nix)
  ];
in { imports = lib.flatten _hyprPlugins; }
