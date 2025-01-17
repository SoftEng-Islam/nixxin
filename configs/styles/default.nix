{ pkgs, lib, settings, ... }:
let
  # base24 = builtins.fetchurl {
  #   url =
  #     "file:///home/${settings.username}/nixxin/configs/styles/base24.yaml"; # Local path to the file
  #   # To Generate The sha256
  #   # sha256sum ~/nixxin/configs/styles/base24.yaml
  #   sha256 =
  #     "8aa7ecf8e86f7149f958ad9674f5ca0766bef6d9d2775ebb425186d42cc56049"; # The hash you got
  # };
in {
  stylix = {
    enable = true;
    image = ./wallpapers/eveningSky.png;
    polarity = "dark";
    # base16Scheme = ${pkgs.base16-schemes}/share/themes/${settings.themeName}.yaml
    # base16Scheme = base24;
    base16Scheme = {
      author = "Islam Ahmed";
      scheme = "Nixxin";
      slug = "nixxin";
      base00 = "191724";
      base01 = "1f1d2e";
      base02 = "26233a";
      base03 = "6e6a86";
      base04 = "908caa";
      base05 = "e0def4";
      base06 = "e0def4";
      base07 = "524f67";
      base08 = "e91e63";
      base09 = "ff9800";
      base0A = "ffeb3b";
      base0B = "4caf50";
      base0C = "00bcd4";
      base0D = "3f51b5";
      base0E = "673ab7";
      base0F = "f44336";
    };
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
      sizes = {
        applications = settings.fontSize;
        desktop = settings.fontSize;
        popups = settings.fontSize;
      };
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
      grub.useImage = true;
      regreet.enable = true;
      gtk.enable = true;
      nixos-icons.enable = true;
      plymouth.enable = true;
      nixvim.enable = true;
      gnome-text-editor.enable = true;
    };
  };
  home-manager.sharedModules = [{
    stylix = {
      enable = true;
      # autoEnable = true;
      iconTheme = {
        enable = true;
        package = settings.iconPackage;
        dark = settings.iconNameDark;
        light = settings.iconNameLight;
      };
      targets = {
        zed.enable = true;
        zathura.enable = true;
        wezterm.enable = true;
        vim.enable = true;
        vscode.enable = true;
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
        kitty.variant256Colors = true;
        lazygit.enable = true;
        mako.enable = true;
        hyprland.enable = false;
      };
    };
  }];
  environment.systemPackages = with pkgs; [
    # Icons
    papirus-icon-theme # Pixel perfect icon theme for Linux

    # Plymouth Theme For Nixos:
    plymouth # Boot splash and boot logger
    nixos-bgrt-plymouth # BGRT theme with a spinning NixOS logo
  ];
}
