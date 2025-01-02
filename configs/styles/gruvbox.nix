{ dir, ... }: {
  themeName = "gruvbox-dark-hard";
  wallpaper = "${dir}/wallpapers/gruvbox.png";
  override = null;
  # Override stylix theme of btop.
  btopTheme = "gruvbox_dark_v2";
}
