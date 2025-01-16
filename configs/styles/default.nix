{ pkgs, lib, settings, ... }:
let
  base24 = builtins.fetchurl {
    url =
      "file:///home/${settings.username}/nixxin/configs/styles/base24.yaml"; # Local path to the file
    # To Generate The sha256
    # sha256sum ~/nixxin/configs/styles/base24.yaml
    sha256 =
      "8aa7ecf8e86f7149f958ad9674f5ca0766bef6d9d2775ebb425186d42cc56049"; # The hash you got
  };
in {
  stylix = {
    enable = true;
    image = ./wallpapers/eveningSky.png;
    polarity = "dark";
    # base16Scheme = ${pkgs.base16-schemes}/share/themes/${settings.themeName}.yaml
    base16Scheme = base24;

    opacity = {
      # terminal = settings.opacity;
      # applications = settings.opacity;
      # desktop = settings.opacity;
      # popups = settings.opacity;
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
      # feh.enable = true;
      # fish.enable = true;
      gnome.enable = false;
      grub.enable = false;
      regreet.enable = false;
      gtk.enable = false;
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
        firefox.enable = true;
        foot.enable = true;
        fzf.enable = true;
        gitui.enable = true;
        kitty.enable = true;
        lazygit.enable = true;
        mako.enable = true;
        nixvim.enable = false;
        hyprland.enable = true;
      };
    };
  };
  environment.systemPackages = with pkgs; [
    # Icons
    papirus-icon-theme # Pixel perfect icon theme for Linux

    # Plymouth Theme For Nixos:
    plymouth # Boot splash and boot logger
    nixos-bgrt-plymouth # BGRT theme with a spinning NixOS logo
  ];
}
