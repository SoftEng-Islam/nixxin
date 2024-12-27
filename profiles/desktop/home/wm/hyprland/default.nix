{ inputs, config, lib, settings, pkgs, ... }:
# home.file.".config/hypr/hyprland.conf".text =
#   builtins.readFile ./hypr/hyprland.conf;
# Make stuff work on wayland

# home.file.".config/hypr/hyprland.conf".source = ./hypr/hyprland.conf;
# home.file.".config/hypr/hyprlock.conf".source = ./hypr/hyprlock.conf;
# home.file.".config/hypr/scripts/hyprlock-time.sh".source =
#   ./hypr/scripts/hyprlock-time.sh;
{
  imports = [
    ./hyprland/ags.nix
    ./hyprland/env.nix
    ./hyprland/binds.nix
    ./hyprland/scripts.nix
    ./hyprland/rules.nix
    ./hyprland/settings.nix
    ./hyprland/plugins.nix
    ./hyprland/hyprlock.nix
  ];

  home.packages = with pkgs; [ hyprcursor ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    systemd.enable = true;
    plugins = [
      pkgs.hyprlandPlugins.hyprexpo
      pkgs.hyprlandPlugins.hypr-dynamic-cursors
    ] ++ lib.optional (settings.themeDetails.bordersPlusPlus)
      pkgs.hyprlandPlugins.borders-plus-plus;
  };

}
