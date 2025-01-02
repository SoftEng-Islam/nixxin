{ pkgs, lib, settings, ... }:
let
  themeName = "gruvbox-dark-hard";
  opacity = 0.9;
  # rounding = 25;
  # shadow = true;
  # bordersPlusPlus = false;
in {
  stylix = {
    enable = true;
    image = "${settings.dotfilesDir}/configs/styles/wallpapers/gruvbox.png";
    polarity = "dark";
    override = null;
    btopTheme = "gruvbox_dark_v2";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/${themeName}.yaml";
    opacity = {
      terminal = opacity;
      applications = opacity;
      desktop = opacity;
      popups = opacity;
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
    targets = {
      console.enable = true;
      feh.enable = true;
      fish.enable = true;
      gnome.enable = true;
      grub.enable = true;
      gtk.enable = true;
      nixos-icons.enable = true;
      plymouth.enable = true;
    };
  };
  home-manager.users.${settings.username} = {
    stylix = {
      enable = true;
      iconTheme = {
        enable = true;
        package = settings.iconPackage;
        dark = settings.iconNameDark;
        light = settings.iconNameLight;
      };
      targets = {
        alacritty.enable = true;
        avizo.enable = true;
        bat.enable = true;
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
          lib.mkIf (settings.themeDetails.themeName != null) false;
      };
    };
    qt = {
      enable = true;
      platformTheme.name = settings.qtPlatformTheme;
      style.name = settings.qtStyle;
    };
    gtk = {
      enable = true;
      gtk2.configLocation = "/home/${settings.username}/.config/gtk-2.0/gtkrc";
      # theme = {
      #   name = lib.mkForce settings.gtkTheme;
      #   package = lib.mkForce settings.gtkPackage;
      # };
      gtk3 = {
        bookmarks = [
          "file:///home/${settings.username}/Downloads"
          "file:///home/${settings.username}/Documents"
          "file:///home/${settings.username}/Pictures"
          "file:///home/${settings.username}/Music"
          "file:///home/${settings.username}/Videos"
          "file:///home/${settings.username}/.config"
          "file:///home/${settings.username}/Dev"
          "file:///home/${settings.username}/GitHub"
          # "file:///mnt/Windows"
        ];
      };
    };
  };
}
