{ ... }: {
  home.file.".config/hypr/hyprland.conf".text =
    builtins.readFile ./hypr/hyprland.conf;

  home.file.".config/hypr/hyprlock.conf".text =
    builtins.readFile ./hypr/hyprlock.conf;

  home.file.".config/hypr/scripts/hyprlock-time.sh".text =
    builtins.readFile ./hypr/scripts/hyprlock-time.sh;
}
