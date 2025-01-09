{ settings, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    eww
    ripgrep
    playerctl
    gradience
    adw-gtk3
    jq
    swww
    gtklock
    pamixer
    grimblast
    wf-recorder
    python3Packages.requests
    python3Packages.pillow
    python3Packages.material-color-utilities
    zenity
    socat
    hyprpicker
    wget
    bc
  ];

  home-manager.users.${settings.username} = {
    home.file.".config/eww".source = ./eww;
    home.file.".config/gtklock".source = ./gtklock;
  };
}
