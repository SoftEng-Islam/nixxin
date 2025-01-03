{ pkgs, lib, settings, ... }:
let
  base24 = builtins.fetchurl {
    url =
      "file:///home/${settings.username}/nixxin/configs/styles/base24.yaml"; # Local path to the file
    # To generate the sha256
    # sha256sum /path/to/your/file.yaml
    sha256 =
      "ae7a46b06878dd184cf62b30f3a762a3902a177644363b65333e81bf8e0b5e8b"; # The hash you got
  };
in {
  stylix = {
    enable = true;
    image = ./wallpapers/gruvbox.png;
    polarity = "dark";
    # base16Scheme = ${pkgs.base16-schemes}/share/themes/${settings.themeName}.yaml
    base16Scheme = base24;

    opacity = {
      terminal = settings.opacity;
      applications = settings.opacity;
      desktop = settings.opacity;
      popups = settings.opacity;
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
        kitty.enable = true;
        lazygit.enable = true;
        mako.enable = true;
        nixvim.enable = lib.mkIf (settings.themeName != null) false;
        # hyprland.enable = true;
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
        extraCss = ''
          headerbar, .titlebar,
          .csd:not(.popup):not(tooltip):not(messagedialog) decoration{
            border-radius: 0;
          }
        '';
      };
    };
  };
}
