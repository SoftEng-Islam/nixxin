{ config, lib, settings, ... }: {
  imports = [
    ./themes/stylix.nix

    ./home/cli
    ./home/dev
    ./home/flags
    ./home/media
    ./home/wm/gnome
    ./home/terminal
    ./home/xdg.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  stylix.targets.hyprland.enable = false;

  home = {
    username = settings.username;
    homeDirectory = "/home/${settings.username}";
    stateVersion = settings.homeStateVersion;
    sessionVariables = {
      EDITOR = settings.editor;
      TERM = settings.term;
      BROWSER = settings.browser;
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
  #     name = settings.cursorTheme;
  #     size = settings.cursorSize;
  #     package = settings.cursorPackage;
  #   };
  #   font = {
  #     name = settings.fontName;
  #     package = settings.fontPackage;
  #     size = settings.fontSize;
  #   };
  #   iconTheme = {
  #     name = settings.iconName;
  #     package = settings.iconPackage;
  #   };
  #   theme = {
  #     name = lib.mkForce settings.gtkTheme;
  #     package = lib.mkForce settings.gtkPackage;
  #   };
  #   gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
  # };

  # QT Settings
  qt = {
    # enable = true;
    # platformTheme.name = settings.qtPlatformTheme;
    # style.name = settings.qtStyle;
  };
}
