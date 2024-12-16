{ settings, pkgs, config, ... }:
let
  theme = {
    name = "adw-gtk3-dark";
    package = pkgs.adw-gtk3;
  };
  iconTheme = {
    name = "MoreWaita";
    package = pkgs.morewaita-icon-theme;
  };
  font = {
    name = settings.font;
    package = settings.fontPkg;
    size = settings.fontSize;
  };
  cursorTheme = {
    name = settings.cursorTheme;
    size = settings.cursorSize;
    package = settings.cursorPackage;
  };
in {
  home = {
    # packages = with pkgs;
    #   [
    #     # cantarell-fonts
    #     # font-awesome
    #     # theme.package
    #     # font.package
    #   ];
    pointerCursor = cursorTheme // { gtk.enable = true; };
  };

  fonts.fontconfig.enable = true;

  gtk = {
    inherit font cursorTheme iconTheme;
    theme.name = theme.name;
    enable = true;
  };

  qt = {
    enable = true;
    platformTheme.name = "kde";
  };

  home.file.".local/share/flatpak/overrides/global".text = let
    dirs = [
      "/nix/store:ro"
      "xdg-config/gtk-3.0:ro"
      "xdg-config/gtk-4.0:ro"
      "${config.xdg.dataHome}/icons:ro"
    ];
  in ''
    [Context]
    filesystems=${builtins.concatStringsSep ";" dirs}
  '';
}
