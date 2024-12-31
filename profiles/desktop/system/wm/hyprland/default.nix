{ inputs, self, impurity, pkgs, settings, ... }: {
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
  #     xwayland.enable = true;
  #     enable = true;
  #     withUWSM = false; # Launch Hyprland with the UWSM session manager.
  #     package = pkgs.hyprland;
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
    extraSpecialArgs = { inherit inputs settings self; };
    users.${settings.username} = ./end;
  };

  environment.systemPackages = with pkgs; [

    # gui
    blueberry
    d-spy
    # figma-linux
    # kolourpaint
    # github-desktop
    icon-library
    qt5.qtimageformats
    yad

    # tools
    bat
    eza
    fd
    ripgrep
    fzf
    socat
    jq
    gojq
    acpi
    libnotify
    killall
    zip
    unzip
    starship
    showmethekey
    ydotool

    # theming tools
    gradience

    # hyprland
    launcher
    temurin-jre-bin
    brightnessctl
    cliphist
    fuzzel
    grim
    hyprpicker
    tesseract
    imagemagick
    pavucontrol
    playerctl
    swappy
    swaylock-effects
    swayidle
    slurp
    swww
    wayshot
    wlsunset
    wl-clipboard
    wf-recorder

    # langs
    nodejs
    gjs
    bun
    cargo
    go
    gcc
    typescript
    eslint
    # very important stuff
    # uwuify

    adwaita-qt6
    adw-gtk3
    material-symbols

    # albert # Fast and flexible keyboard launcher
    uwsm # Universal wayland session manager
    fd # A simple, fast and user-friendly alternative to find
    gpu-screen-recorder # A screen recorder that has minimal impact on system performance by recording a window using the GPU only
    gpu-screen-recorder-gtk # GTK frontend for gpu-screen-recorder.
    gtk-engine-murrine # for gtk themes
    hyprcursor # The hyprland cursor format, library and utilities
    # hyprgui # unstable GUI for configuring Hyprland written in Rust
    # hypridle # Hyprland's idle daemon
    # hyprland-protocols # Wayland protocol extensions for Hyprland
    # hyprlang # The official implementation library for the hypr config language
    # hyprlauncher # GUI for launching applications, written in Rust
    # hyprlock # Hyprland's GPU-accelerated screen locking utility
    # hyprnotify # DBus Implementation of Freedesktop Notification spec for 'hyprctl notify'
    # hyprpaper # A blazing fast wayland wallpaper utility
    # hyprpicker # A wlroots-compatible Wayland color picker that does not suck
    # hyprshot # Hyprshot is an utility to easily take screenshots in Hyprland using your mouse.
    # hyprutils # Small C++ library for utilities used across the Hypr* ecosystem
    # hyprwayland-scanner # A Hyprland version of wayland-scanner in and for C++
  ];
}
