{ inputs, pkgs, ... }: {
  imports = [ ./common/wayland.nix ./common/fonts.nix ];
  programs = {
    uwsm.enable = true;
    xwayland.enable =
      false; # Xwayland (an X server for interfacing X11 apps with the Wayland protocol).
    hyprlock.enable = true; # Hyprland’s GPU-accelerated screen locking utility.
    hyprland = {
      enable = true;
      withUWSM =
        true; # Launch Hyprland with the UWSM (Universal Wayland Session Manager) session manager.
      package = inputs.hyprland.packages.${pkgs.system}.default;
      portalPackage =
        inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
    };
  };

  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys =
      [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      # common.default = ["gtk"];
      hyprland.default = [ "hyprland" ];
    };

    extraPortals = [
      # pkgs.xdg-desktop-portal-gtk
    ];
  };

  security = {
    polkit.enable = true;
    pam.services.astal-auth = { };
  };
  services = {
    hypridle.enable =
      false; # Whether to enable hypridle, Hyprland’s idle daemon.
  };
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart =
          "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
  environment.systemPackages = with pkgs; [
    # albert # Fast and flexible keyboard launcher
    ags # A EWW-inspired widget system as a GJS library
    brightnessctl # This program allows you read and control device brightness
    fd # A simple, fast and user-friendly alternative to find
    gpu-screen-recorder # A screen recorder that has minimal impact on system performance by recording a window using the GPU only
    gpu-screen-recorder-gtk # GTK frontend for gpu-screen-recorder.
    hyprcursor # The hyprland cursor format, library and utilities
    # hyprgui # unstable GUI for configuring Hyprland written in Rust
    hypridle # Hyprland's idle daemon
    hyprland # A dynamic tiling Wayland compositor that doesn't sacrifice on its looks
    hyprland-protocols # Wayland protocol extensions for Hyprland
    hyprlandPlugins.hyprbars # Hyprland window title plugin
    hyprlandPlugins.hyprexpo # Hyprland workspaces overview plugin
    hyprlang # The official implementation library for the hypr config language
    hyprlauncher # GUI for launching applications, written in Rust
    hyprlock # Hyprland's GPU-accelerated screen locking utility
    hyprnotify # DBus Implementation of Freedesktop Notification spec for 'hyprctl notify'
    hyprpaper # A blazing fast wayland wallpaper utility
    hyprpicker # A wlroots-compatible Wayland color picker that does not suck
    hyprshot # Hyprshot is an utility to easily take screenshots in Hyprland using your mouse.
    hyprutils # Small C++ library for utilities used across the Hypr* ecosystem
    hyprwayland-scanner # A Hyprland version of wayland-scanner in and for C++
  ];
}
