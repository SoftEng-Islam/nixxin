{ lib, settings, pkgs, ... }: {

  # swww = "swww img";
  # effect = "--transition-bezier .43,1.19,1,.4 --transition-fps 30 --transition-type grow --transition-pos 0.925,0.977 --transition-duration 2";

  imports = [
    ./ags.nix
    ./env.nix
    ./binds.nix
    ./scripts.nix
    ./rules.nix
    ./settings.nix
    ./plugins.nix
    ./hyprlock.nix
  ];

  # make stuff work on wayland
  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    systemd.enable = true;
    plugins = [
      pkgs.hyprbars
      pkgs.hyprlandPlugins.hyprexpo
      pkgs.hyprlandPlugins.hypr-dynamic-cursors
    ] ++ lib.optional (settings.themeDetails.bordersPlusPlus)
      pkgs.hyprlandPlugins.borders-plus-plus;
  };
  home.packages = with pkgs; [ hyprcursor ];
}