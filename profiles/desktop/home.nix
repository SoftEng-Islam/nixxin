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
  xdg = {
    enable = true;
    configFile."gtk-4.0/gtk.css".enable = lib.mkForce false;
    userDirs = {
      enable = true;
      createDirectories = true;
      music = "${config.home.homeDirectory}/Music";
      videos = "${config.home.homeDirectory}/Videos";
      pictures = "${config.home.homeDirectory}/Pictures";
      download = "${config.home.homeDirectory}/Downloads";
      documents = "${config.home.homeDirectory}/Documents";
      templates = null;
      desktop = null;
      publicShare = null;
      extraConfig = {
        XDG_DOTFILES_DIR = "${mySettings.dotfilesDir}";
        XDG_BOOK_DIR = "${config.home.homeDirectory}/Books";
      };
    };
  };

  # disable manuals as nmd fails to build often
  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };

  # QT Settings
  qt = {
    enable = true;
    platformTheme.name = mySettings.qtPlatformTheme;
    style.name = mySettings.qtStyle;
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
