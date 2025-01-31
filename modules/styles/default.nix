{ pkgs, settings, ... }:
let
  # base24 = builtins.fetchurl {
  #   url =
  #     "file:///home/${settings.users.selected.username}/nixxin/configs/styles/base24.yaml"; # Local path to the file
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
      base00 = "0A0A0A";
      base01 = "171717";
      base02 = "262626";
      base03 = "404040";
      base04 = "525252";
      base05 = "A3A3A3";
      base06 = "E5E5E5";
      base07 = "FAFAFA";
      base08 = "B91C1C";
      base09 = "C2410C";
      base0A = "CA8A04";
      base0B = "15803D";
      base0C = "0E7490";
      base0D = "1D4ED8";
      base0E = "7E22CE";
      base0F = "500724";
    };
    opacity = {
      # terminal = settings.opacity;
      # applications = settings.opacity;
      # desktop = settings.opacity;
      # popups = settings.opacity;
    };
    cursor = {
      size = settings.style.cursor.size;
      name = settings.style.cursor.name;
      package = settings.style.cursor.package;
    };
    fonts = {
      sizes = {
        applications = settings.fonts.main.size.applications;
        desktop = settings.fonts.main.size.desktop;
        popups = settings.fonts.main.size.popups;
      };

      # ---- Monospace Fonts ---- #
      monospace.name = settings.fonts.monospace.name;
      monospace.package = settings.fonts.monospace.package;

      # ---- Serif Fonts ---- #
      serif.name = settings.fonts.serif.name;
      serif.package = settings.fonts.serif.package;

      # ---- SansSerif Fonts ---- #
      sansSerif.name = settings.fonts.sansSerif.name;
      sansSerif.package = settings.fonts.sansSerif.package;

      # ---- Emoji ---- #
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji"; # Keep Noto Color Emoji for emojis
      };
    };
    targets = {
      console.enable = true;
      feh.enable = true;
      fish.enable = true;
      # gnome.enable = true;
      # gnome-text-editor.enable = true;
      grub.enable = true;
      grub.useImage = true;
      regreet.enable = true;
      gtk.enable = true;
      nixos-icons.enable = true;
      plymouth.enable = true;
      nixvim.enable = true;
    };
  };
  home-manager.sharedModules = [{
    stylix = {
      enable = true;
      # autoEnable = true;
      iconTheme = {
        enable = true;
        light = settings.style.icons.nameInLight;
        dark = settings.style.icons.nameInDark;
        package = settings.style.icons.package;
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
