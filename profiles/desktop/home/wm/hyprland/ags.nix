{ inputs, pkgs, mySettings, lib, config, ... }:
let
  details = mySettings.themeDetails;
  asztal =
    pkgs.callPackage ../../../../../non-nix/ags/default.nix { inherit inputs; };
  agsColors = {
    wallpaper = details.wallpaper;
    theme = {
      blur = (1 - details.opacity) * 100;
      radius = details.rounding;
      shadows = details.shadow;
      palette = {
        primary = {
          bg = "#${config.lib.stylix.colors.base0D}";
          fg = "#${config.lib.stylix.colors.base00}";
        };
        secondary = {
          bg = "#${config.lib.stylix.colors.base0E}";
          fg = "#${config.lib.stylix.colors.base00}";
        };
        error = {
          bg = "#${config.lib.stylix.colors.base06}";
          fg = "#${config.lib.stylix.colors.base00}";
        };
        bg = "#${config.lib.stylix.colors.base00}";
        fg = "#${config.lib.stylix.colors.base05}";
        widget = "#${config.lib.stylix.colors.base05}";
        border = "#${config.lib.stylix.colors.base05}";
      };
    };
    font = {
      size = mySettings.fontSize;
      name = mySettings.fontName;
    };
    widget = { opacity = details.opacity * 100; };
  };
  agsOptions = lib.recursiveUpdate agsColors details.ags;
in {
  imports = [ inputs.ags.homeManagerModules.default ];
  home.packages = with pkgs; [
    asztal
    bun
    fd
    dart-sass
    gtk3
    pulsemixer
    networkmanager
    pavucontrol
  ];
  home.file.".cache/ags/options-nix.json".text = (builtins.toJSON agsOptions);

  programs.ags = {
    enable = true;
    configDir = ../../../../../non-nix/ags;
  };

}
