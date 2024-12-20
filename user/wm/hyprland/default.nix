{ lib, mySettings, pkgs, ... }: {

  # swww = "swww img";
  # effect = "--transition-bezier .43,1.19,1,.4 --transition-fps 30 --transition-type grow --transition-pos 0.925,0.977 --transition-duration 2";

  imports = [
    ./ags.nix
    ./binds.nix
    ./env.nix
    #    ./hyprlock.nix
    ./plugins.nix
    ./rules.nix
    ./scripts.nix
    ./settings.nix
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
    plugins = with pkgs;
      [
        hyprlandPlugins.hyprbars
        hyprlandPlugins.hyprexpo
        hyprlandPlugins.hypr-dynamic-cursors
      ] ++ lib.optional (mySettings.themeDetails.bordersPlusPlus)
      hyprlandPlugins.borders-plus-plus;
  };
  # home.packages = with pkgs; [ hyprcursor ];
}
