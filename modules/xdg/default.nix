{ settings, config, lib, pkgs, ... }:
let
  inherit (lib) optionals mkIf;
  cacheInHome = "/home/${settings.user.username}/.cache";
  mimeTypes = import (./. + "/mimeTypes.nix") { };

  # ---- Associations ---- #
  xdgAssociations = type: program: list:
    builtins.listToAttrs (map (e: {
      name = "${type}/${e}";
      value = program;
    }) list);

  # ---- Set Your Default Apps ---- #
  browser = [ settings.modules.xdg.defaults.webBrowser ];
  imageViewer = [ settings.modules.xdg.defaults.imageViewer ];
  videoPlayer = [ settings.modules.xdg.defaults.videoPlayer ];
  audioPlayer = [ settings.modules.xdg.defaults.audioPlayer ];
  editor = [ settings.modules.xdg.defaults.editor ];
  torrentApp = [ settings.modules.xdg.defaults.torrentApp ];
  exeRunner = [ settings.modules.xdg.defaults.windowsExeFileRunner ];

  windowsApps = xdgAssociations "application" exeRunner [ "x-msdos-program" ];
  editors = xdgAssociations "editor" editor mimeTypes._text;
  image = xdgAssociations "image" imageViewer mimeTypes._image;
  video = xdgAssociations "video" videoPlayer mimeTypes._video;
  audio = xdgAssociations "audio" audioPlayer mimeTypes._audio;

  webBrowser = (xdgAssociations "application" browser mimeTypes._browser)
    // (xdgAssociations "x-scheme-handler" browser mimeTypes._web);

  # XDG MIME types
  associations = builtins.mapAttrs (_: v: (map (e: "${e}.desktop") v)) ({
    "application/pdf" = [ "org.pwmt.zathura-pdf-mupdf" ];
    "application/zip" = [ "org.gnome.FileRoller" ];
    "inode/directory" = [ "org.gnome.Nautilus" ];
    "application/x-ms-dos-executable" = [ "wine" ];
    "text/plain" = [ "org.gnome.TextEditor" ];
    "text/html" = browser;
    "application/x-bittorrent" = torrentApp;
    "x-scheme-handler/magnet" = torrentApp;

  } // editors // image // video // audio // webBrowser // windowsApps);

in mkIf (settings.modules.xdg.enable) {
  environment.variables = {
    # XDG_RUNTIME_DIR = "/run/user/$(id -u)";
    # XDG_RUNTIME_DIR = "/run/user/${toString config.users.users.${settings.user.username}.uid}";
    # XDG_RUNTIME_DIR = "/run/user/1000";

    # Don't set this var
    # XDG_CURRENT_DESKTOP = "Hyprland"; #"GNOME" or "Hyprland";

    XDG_SESSION_TYPE = "wayland";

    XDG_CACHE_HOME = cacheInHome;
    XDG_CONFIG_HOME = "/home/${settings.user.username}/.config";
    XDG_PICTURES_DIR = "/home/${settings.user.username}/Pictures";
    XDG_SCREENSHOTS_DIR =
      "/home/${settings.user.username}/Pictures/Screenshots";
  };
  environment.sessionVariables = {
    XDG_DATA_DIRS = [
      "${pkgs.gsettings-desktop-schemas}/share"
      "${pkgs.nautilus}/share"
      "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}"
      "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
      "${pkgs.gtk4}/share/gsettings-schemas/${pkgs.gtk4.name}"
      "/home/${settings.user.username}/.local/share:/usr/local/share:/usr/share"
      "/run/current-system/sw/share"
    ];
  };
  xdg = {
    portal = {
      enable = true;
      wlr.enable = true;
      xdgOpenUsePortal = true;
      config = {
        common = {
          default = "*"; # "*" or "gtk"
          "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
          "org.freedesktop.impl.portal.ScreenCast" = [ "hyprland" ];
          "org.freedesktop.impl.portal.Screenshot" = [ "hyprland" ];
          "org.freedesktop.portal.FileChooser" = [ "xdg-desktop-portal-gtk" ];
        };
        hyprland.default = [ "hyprland" "gtk" ];
      };
      extraPortals = with pkgs;
        [
          xdg-desktop-portal-gtk
          # xdg-desktop-portal-hyprland
        ];
    };
  };
  # ---- Under Test ---- #
  # xdg.configFile = {
  #   "fish".source = ./.config/fish;
  #   "foot".source = ./.config/foot;
  #   "fuzzel".source = ./.config/fuzzel;
  #   "mpv".source = ./.config/mpv;
  #   "thorium-flags.conf".source = ./.config/thorium-flags.conf;
  #   "starship.toml".source = ./.config/starship.toml;
  # };

  home-manager.users.${settings.user.username} = {
    xdg = {
      enable = true;
      mime.enable = true;
      # icons.enable = true;
      # configFile."gtk-4.0/gtk.css".enable = lib.mkForce true;
      cacheHome = cacheInHome;
      userDirs = {
        enable = true;
        createDirectories = true;
        music = "/home/${settings.user.username}/Music";
        videos = "/home/${settings.user.username}/Videos";
        pictures = "/home/${settings.user.username}/Pictures";
        download = "/home/${settings.user.username}/Downloads";
        documents = "/home/${settings.user.username}/Documents";
        templates = null;
        desktop = null;
        publicShare = null;
        # data = [ "/usr/share" "/usr/local/share" ];
        # xdg.configFile."mimeapps.list".force = true;
        # xdg.configFile."xdg-desktop-portal-wlr/config".text = ''
        #   [screencast]
        #   max_fps=30
        #   chooser_type=simple
        #   chooser_cmd=slurp -d -b "${themeColors.background}bf" -c "${themeColors.primary}" -F "Iosevka NF" -w 1 -f %o -or
        # '';
        extraConfig = {
          XDG_DOTFILES_DIR = "${settings.common.dotfilesDir}";
          XDG_BOOK_DIR = "/home/${settings.user.username}/Books";
          XDG_SCREENSHOTS_DIR =
            "/home/${settings.user.username}/Pictures/Screenshots";
        };
      };
      mimeApps = {
        enable = true;
        defaultApplications = associations;
        # defaultapps = with lib;
        #   with mimeTypes;
        #   mkMerge (mapAttrsToList (n: ms: genAttrs ms (_: [ "${n}.desktop" ])) {
        #     # TODO: make nvim use kitty as terminal
        #     "kitty-open" = text ++ [ "text/*" ];
        #     "google-chrome" = html ++ web;
        #     "imv" = images;
        #     "mpv" = media;
        #     "org.gnome.FileRoller" = archives;
        #     "kitty" = [ "application/x-shellscript" ];
        #     "amfora" = [ "x-scheme-handler/gemini" ];
        #     "Postman" = [ "x-scheme-handler/postman" ];
        #     # "neomutt" = [
        #     #   "message/rfc822"
        #     #   "x-scheme-handler/mailto"
        #     # ];
        #     # "newsboat" = [
        #     #   "x-scheme-handler/news"
        #     #   "x-scheme-handler/rss+xml"
        #     #   "x-scheme-handler/x-extension-rss"
        #     #   "x-scheme-handler/feed"
        #     # ];
        #     # transmission-gtk =
        #     #   [ "application/x-bittorrent" "x-scheme-handler/magnet" ];
        #   });
      };
    };
  };

  # xdg-desktop-portal works by exposing a series of D-Bus interfaces
  # known as portals under a well-known name
  # (org.freedesktop.portal.Desktop) and object path
  # (/org/freedesktop/portal/desktop).
  # The portal interfaces include APIs for file access, opening URIs,
  # printing and others.
  services.dbus.enable = lib.mkDefault true;
  # xdg.portal.xdgOpenUsePortal = true;

  environment = {
    # etc."mime.types".source = ./dotfiles/mime.types;

    # shellAliases.open = "xdg-open";
    # shellAliases.o = "xdg-open";
  };

  environment.systemPackages = with pkgs; [
    # used by `gio open` and xdp-gtk
    (pkgs.writeShellScriptBin "xdg-terminal-exec" ''
      foot "$@"
    '')
    xdg-launch
    desktop-file-utils
    xdg-dbus-proxy # DBus proxy for Flatpak and others
    xdg-desktop-portal # Desktop integration portals for sandboxed apps
    xdg-desktop-portal-gnome
    xdg-desktop-portal-gtk # Desktop integration portals for sandboxed apps
    xdg-desktop-portal-wlr # xdg-desktop-portal backend for wlroots
    xdg-user-dirs # Tool to help manage well known user directories like the desktop folder and the music folder
    xdg-utils # A set of command line tools that assist apps with a variety of desktop integration tasks
    libxdg_basedir # Implementation of the XDG Base Directory specification
    shared-mime-info # Database of common MIME types
  ];
}
