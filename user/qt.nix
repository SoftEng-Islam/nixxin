{ pkgs, ... }: {
  # platform theme "gtk" or "gnome"
  # name of the qt theme
  # package to use
  qt = {
    enable = true;
    platformTheme = "gtk";
    style.name = "adwaita-dark";
    style.package = pkgs.adwaita-qt;
  };
}
