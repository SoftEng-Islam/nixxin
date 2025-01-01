{ ... }: {
  themeName = "nord";
  wallpaper = ./wallpapers/nord.jpg;
  override = null;

  # Override stylix theme of btop.
  btopTheme = "nord";

  # Hyprland and ags;
  opacity = 0.9;
  rounding = 25;
  shadow = true;
  bordersPlusPlus = false;
}
