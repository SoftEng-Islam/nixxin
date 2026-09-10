{ settings, lib, ... }:
let
  inherit (lib) optional;
  plugins = settings.modules.desktop.hyprland.plugins;
  _hyprPlugins = [
    (optional plugins.hyprbars ./hyprbars.nix)
  ];
in
{
  imports = lib.flatten _hyprPlugins;
}
