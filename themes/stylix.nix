{ pkgs, lib, settings, ... }:
let details = settings.themeDetails;
in {
  stylix = {
    enable = true;
    polarity = "dark";
    image = details.wallpaper;
    base16Scheme = lib.mkIf (details.themeName != null)
      "${pkgs.base16-schemes}/share/themes/${details.themeName}.yaml";
    override = lib.mkIf (details.override != null) details.override;
    opacity = {
      terminal = details.opacity;
      applications = details.opacity;
      desktop = details.opacity;
      popups = details.opacity;
    };

    cursor = {
      size = settings.cursorSize;
      name = settings.cursorTheme;
      package = settings.cursorPackage;
    };

    fonts = {
      serif = {
        package = settings.fontPackage;
        name = settings.fontName; # Use JetBrains Mono for the serif font
      };

      sansSerif = {
        package = settings.fontPackage;
        name = settings.fontName; # Use JetBrains Mono for the sans-serif font
      };

      monospace = {
        package = settings.fontPackage;
        name = settings.fontName; # JetBrains Mono is a monospace font
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji"; # Keep Noto Color Emoji for emojis
      };
    };
    targets.nixvim.enable =
      lib.mkIf (settings.themeDetails.themeName != null) false;
  };
}
