{ pkgs, lib, mySettings, ... }:
let details = mySettings.themeDetails;
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
      size = mySettings.cursorSize;
      name = mySettings.cursorTheme;
      package = mySettings.cursorPackage;
    };

    fonts = {
      serif = {
        package = mySettings.fontPackage;
        name = mySettings.fontName; # Use JetBrains Mono for the serif font
      };

      sansSerif = {
        package = mySettings.fontPackage;
        name = mySettings.fontName; # Use JetBrains Mono for the sans-serif font
      };

      monospace = {
        package = mySettings.fontPackage;
        name = mySettings.fontName; # JetBrains Mono is a monospace font
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji"; # Keep Noto Color Emoji for emojis
      };
    };
    iconTheme = {
      enable = true;
      package = mySettings.iconPackage;
      dark = mySettings.iconNameDark;
      light = mySettings.iconNameLight;
    };
    targets.nixvim.enable =
      lib.mkIf (mySettings.themeDetails.themeName != null) false;
  };

}
