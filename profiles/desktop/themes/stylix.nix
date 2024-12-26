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
      serif.name = mySettings.serifFont;
      sansSerif.name = mySettings.sansSerifFont;
      monospace.name = mySettings.fontName;
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
    targets = {
      bat.enable = true;
      alacritty.enable = true;
      avizo.enable = true;
      btop.enable = true;
      cava.enable = true;
      dunst.enable = true;
      emacs.enable = true;
      feh.enable = true;
      firefox.enable = true;
      fish.enable = true;
      foot.enable = true;
      fzf.enable = true;
      gitui.enable = true;
      gnome.enable = true;
      gtk.enable = true;
      # hyprland.enable = true;
      kitty.enable = true;
      lazygit.enable = true;
      mako.enable = true;
      nixvim.enable =
        lib.mkIf (mySettings.themeDetails.themeName != null) false;
    };
  };
}
