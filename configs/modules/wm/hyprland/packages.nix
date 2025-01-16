{ pkgs, inputs, ... }: {
  environment.systemPackages = with pkgs; [
    # Install Hyprland from Inputes (latest version)
    inputs.hyprland.packages.${system}.hyprland
    # A wlroots-compatible Wayland color picker that does not suck
    inputs.hyprpicker.packages.${system}.hyprpicker

    # gui
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
    starship
    showmethekey
    ydotool

    # theming tools
    gradience

    # hyprland
    temurin-jre-bin
    grim
    tesseract
    imagemagick
    pavucontrol
    playerctl
    swappy
    slurp
    swww
    wayshot
    wlsunset
    wf-recorder

    # langs
    nodejs
    bun
    cargo
    go
    typescript
    eslint
    # very important stuff
    # uwuify

    adwaita-qt6
    adw-gtk3
    material-symbols

    # albert # Fast and flexible keyboard launcher
    fd # A simple, fast and user-friendly alternative to find
    gpu-screen-recorder # A screen recorder that has minimal impact on system performance by recording a window using the GPU only
    gpu-screen-recorder-gtk # GTK frontend for gpu-screen-recorder.
    gtk-engine-murrine # for gtk themes
    hyprcursor # The hyprland cursor format, library and utilities
    # hyprgui # unstable GUI for configuring Hyprland written in Rust
    # hyprland-protocols # Wayland protocol extensions for Hyprland
    # hyprlang # The official implementation library for the hypr config language
    # hyprlauncher # GUI for launching applications, written in Rust
    # hyprlock # Hyprland's GPU-accelerated screen locking utility
    # hyprnotify # DBus Implementation of Freedesktop Notification spec for 'hyprctl notify'
    # hyprpaper # A blazing fast wayland wallpaper utility
    # hyprshot # Hyprshot is an utility to easily take screenshots in Hyprland using your mouse.
    # hyprutils # Small C++ library for utilities used across the Hypr* ecosystem
    # hyprwayland-scanner # A Hyprland version of wayland-scanner in and for C++
  ];
}
