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
      serif.name = settings.serifFont;
      serif.package = settings.serifPackage;
      sansSerif.name = settings.sansSerifFont;
      sansSerif.package = settings.sansSerifPackage;
      monospace.name = settings.fontName;
      monospace.package = settings.fontPackage;
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji"; # Keep Noto Color Emoji for emojis
      };
    };
    iconTheme = {
      enable = true;
      package = settings.iconPackage;
      dark = settings.iconNameDark;
      light = settings.iconNameLight;
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
      nixvim.enable = lib.mkIf (settings.themeDetails.themeName != null) false;
    };
  };
}
