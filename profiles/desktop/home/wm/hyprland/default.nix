{ ... }: {
  # home.file.".config/hypr/hyprland.conf".text =
  #   builtins.readFile ./hypr/hyprland.conf;

  home.file.".config/hypr/hyprland.conf".source = ./hypr/hyprland.conf;
  home.file.".config/hypr/hyprlock.conf".source = ./hypr/hyprlock.conf;
  home.file.".config/hypr/scripts/hyprlock-time.sh".source =
    ./hypr/scripts/hyprlock-time.sh;
}
