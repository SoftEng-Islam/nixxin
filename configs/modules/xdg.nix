{ config, settings, lib, pkgs, ... }:
let
  # find /nix/store/ -name "*qbittorrent*.desktop"
  browser = [ "brave-browser" ];
  imageViewer = [ "org.gnome.Loupe" ];
  videoPlayer = [ "io.github.celluloid_player.Celluloid" ];
  audioPlayer = [ "io.bassi.Amberol" ];
  editor = [ "code.desktop" ];
  fileManager = [ "org.gnome.Nautilus.desktop" ];
  torrentApp = [ "org.qbittorrent.qBittorrent.desktop" ];

  xdgAssociations = type: program: list:
    builtins.listToAttrs (map (e: {
      name = "${type}/${e}";
      value = program;
    }) list);

  editors = xdgAssociations "editor" editor [
    "text/english"
    "text/plain"
    "text/x-makefile"
    "text/x-c++hdr"
    "text/x-c++src"
    "text/x-chdr"
    "text/x-csrc"
    "text/x-java"
    "text/x-moc"
    "text/x-pascal"
    "text/x-tcl"
    "text/x-tex"
    "application/x-shellscript"
    "text/x-c"
    "text/x-c++"
  ];
  filesManager = xdgAssociations "file" fileManager [ "inode/directory" ];
  torrent = xdgAssociations "torrents" torrentApp [ "x-scheme-handler/magnet" ];
  image = xdgAssociations "image" imageViewer [ "png" "svg" "jpeg" "gif" ];
  video = xdgAssociations "video" videoPlayer [ "mp4" "avi" "mkv" "wmv" "ts" ];
  audio = xdgAssociations "audio" audioPlayer [ "mp3" "flac" "wav" "aac" ];

  browserTypes = (xdgAssociations "application" browser [
    "json"
    "x-extension-htm"
    "x-extension-html"
    "x-extension-shtml"
    "x-extension-xht"
    "x-extension-xhtml"
  ]) // (xdgAssociations "x-scheme-handler" browser [
    "about"
    "ftp"
    "http"
    "https"
    "unknown"
  ]);

  # XDG MIME types
  associations = builtins.mapAttrs (_: v: (map (e: "${e}.desktop") v)) ({
    "application/pdf" = [ "org.pwmt.zathura-pdf-mupdf" ];
    "text/html" = browser;
    "text/plain" = [ "org.gnome.TextEditor" ];
    # "x-scheme-handler/chrome" = [ "google-chrome" ];
    # "inode/directory" = [ "nautilus" ];
  } // editors // filesManager // torrent // image // video // audio
    // browserTypes);

in {
  environment.variables = {
    # XDG_RUNTIME_DIR = "/run/user/${toString config.users.users.softeng.uid}";
    # XDG_RUNTIME_DIR = "/run/user/$(id -u)";
    # XDG_CURRENT_DESKTOP = "Hyprland"; #"GNOME" or "Hyprland";
    XDG_PICTURES_DIR = "~/Pictures";
    XDG_RUNTIME_DIR = "/run/user/1000";
    XDG_SCREENSHOTS_DIR = "~/Pictures/Screenshots";
    XDG_SESSION_TYPE = "wayland";
  };

  xdg = {
    portal = {
      enable = true;
      wlr.enable = true;
      xdgOpenUsePortal = true;
      config = {
        common.default = [ "gtk" ];
        hyprland.default = [ "gtk" "hyprland" ];
      };
      extraPortals = [ pkgs.xdg-desktop-portal pkgs.xdg-desktop-portal-gtk ];
      configPackages = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal ];
    };
  };

  home-manager.users.${settings.username} = {
    xdg = {
      enable = true;
      configFile."gtk-4.0/gtk.css".enable = lib.mkForce false;
      cacheHome = "/home/${settings.username}/.local/cache";
      userDirs = {
        enable = true;
        createDirectories = true;
        music = "/home/${settings.username}/Music";
        videos = "/home/${settings.username}/Videos";
        pictures = "/home/${settings.username}/Pictures";
        download = "/home/${settings.username}/Downloads";
        documents = "/home/${settings.username}/Documents";
        templates = null;
        desktop = null;
        publicShare = null;
        extraConfig = {
          XDG_DOTFILES_DIR = "${settings.dotfilesDir}";
          XDG_BOOK_DIR = "/home/${settings.username}/Books";
          XDG_SCREENSHOTS_DIR =
            "/home/${settings.username}/pictures/Screenshots";
        };
      };
      desktopEntries."org.gnome.Settings" = {
        name = "Settings";
        comment = "Gnome Control Center";
        icon = "org.gnome.Settings";
        exec =
          "env XDG_CURRENT_DESKTOP=gnome ${pkgs.gnome-control-center}/bin/gnome-control-center";
        categories = [ "X-Preferences" ];
        terminal = false;
      };

      mimeApps = {
        enable = true;
        defaultApplications = associations;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    xdg-dbus-proxy # DBus proxy for Flatpak and others
    xdg-desktop-portal # Desktop integration portals for sandboxed apps
    xdg-desktop-portal-gnome # Backend implementation for xdg-desktop-portal for the GNOME desktop environment
    xdg-desktop-portal-gtk # Desktop integration portals for sandboxed apps
    xdg-desktop-portal-hyprland # xdg-desktop-portal backend for Hyprland
    xdg-desktop-portal-wlr # xdg-desktop-portal backend for wlroots
    xdg-user-dirs # Tool to help manage well known user directories like the desktop folder and the music folder
    xdg-utils # A set of command line tools that assist applications with a variety of desktop integration tasks
    libxdg_basedir # Implementation of the XDG Base Directory specification
  ];
}
