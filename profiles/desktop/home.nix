{ config, lib, mySettings, ... }: {
  imports = [
    ./themes/stylix.nix

    ./home/cli
    ./home/dev
    ./home/flags
    ./home/media
    ./home/wm/gnome
    ./home/wm/hyprland
    ./home/terminal
    ./home/xdg.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  stylix.targets.hyprland.enable = false;

  home = {
    username = mySettings.username;
    homeDirectory = "/home/${mySettings.username}";
    stateVersion = mySettings.homeStateVersion;
    sessionVariables = {
      EDITOR = mySettings.editor;
      TERM = mySettings.term;
      BROWSER = mySettings.browser;
    };
  };
  # disable manuals as nmd fails to build often
  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };

  # gtk = {
  #   enable = true;
  #   cursorTheme = {
  #     name = mySettings.cursorTheme;
  #     size = mySettings.cursorSize;
  #     package = mySettings.cursorPackage;
  #   };
  #   font = {
  #     name = mySettings.fontName;
  #     package = mySettings.fontPackage;
  #     size = mySettings.fontSize;
  #   };
  #   iconTheme = {
  #     name = mySettings.iconName;
  #     package = mySettings.iconPackage;
  #   };
  #   theme = {
  #     name = lib.mkForce mySettings.gtkTheme;
  #     package = lib.mkForce mySettings.gtkPackage;
  #   };
  #   gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
  # };

  # QT Settings
  qt = {
    enable = true;
    platformTheme.name = mySettings.qtPlatformTheme;
    style.name = mySettings.qtStyle;
  };
}
