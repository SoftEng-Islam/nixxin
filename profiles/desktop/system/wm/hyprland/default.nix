{ inputs, self, pkgs, settings, ... }: {

  imports = [ ./packages.nix ];

  # Run Hyprland in a nested session for testing within GNOME:
  # Install waypipe and weston: These tools allow you to run Wayland compositors inside existing Wayland/X11 sessions.
  # Start Nested Hyprland: Inside GNOME, run:
  # `weston --socket=wayland-1 &`
  # `WAYLAND_DISPLAY=wayland-1 Hyprland`
  # services.xserver.displayManager.startx.enable = false;
  # programs = {
  #   uwsm.enable = false;
  #   hyprlock.enable = false;
  #   xwayland.enable = true;
  #   hyprland = {
  #     enable = true;
  #     package = pkgs.hyprland;
  #     xwayland.enable = true;
  #     systemd.enable = true;
  #     withUWSM = false; # Launch Hyprland with the UWSM session manager.
  #   };
  # };

  # home.file.".config/hypr/hyprland.conf".text = builtins.readFile ./hypr/hyprland.conf;
  # home.file.".config/hypr/hyprland.conf".source = ./hypr/hyprland.conf;
  # home.file.".config/hypr/hyprlock.conf".source = ./hypr/hyprlock.conf;
  # home.file.".config/hypr/scripts/hyprlock-time.sh".source = ./hypr/scripts/hyprlock-time.sh;
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # hint electron apps to use wayland
    MOZ_ENABLE_WAYLAND = "1"; # ensure enable wayland for Firefox
    WLR_RENDERER_ALLOW_SOFTWARE = "1"; # enable software rendering for wlroots
    WLR_NO_HARDWARE_CURSORS = "1"; # disable hardware cursors for wlroots
    NIXOS_XDG_OPEN_USE_PORTAL = "1"; # needed to open apps after web login
  };

  home-manager = {
    # users.${settings.username} = ./end;
    # wayland.windowManager.hyprland.enable = true;
  };

}
