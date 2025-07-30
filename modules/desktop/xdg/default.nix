# =>=>=>=>=>=>=>=>=>=>=>=>=>=>=>=>
# xdg.nix
# =>=>=>=>=>=>=>=>=>=>=>=>=>=>=>=>
#
# Set up and enforce XDG compliance. Other modules will take care of their own,
# but this takes care of the general case
{ settings, lib, pkgs, ... }:
let
  inherit (lib) mkIf;

  username = settings.user.username;
  xdg = settings.modules.desktop.xdg;
  mimeTypes = import (./. + "/mimeTypes.nix") { };

  # ---- Associations ---- #
  xdgAssociations = type: program: list:
    builtins.listToAttrs (map (e: {
      name = "${type}/${e}";
      value = program;
    }) list);

  # ---- Set Your Default Apps ---- #
  browser = [ xdg.defaults.webBrowser ];
  imageViewer = [ xdg.defaults.imageViewer ];
  videoPlayer = [ xdg.defaults.videoPlayer ];
  audioPlayer = [ xdg.defaults.audioPlayer ];
  editor = [ xdg.defaults.editor ];
  torrentApp = [ xdg.defaults.torrentApp ];
  exeRunner = [ xdg.defaults.windowsExeFileRunner ];

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
in {
  environment = let
    xdgConventions = {
      # These are the defaults, and xdg.enable does set them, but due to load
      # order, they're not set before environment.variables are set, which could
      # cause race conditions.
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_BIN_HOME = "$HOME/.local/bin";
    };
  in {
    # etc."mime.types".source = ./dotfiles/mime.types;
    # shellAliases.open = "xdg-open";
    # shellAliases.o = "xdg-open";

    variables = {
      # Enables portal-based access for apps like VSCode to integrate better with Wayland.
      GTK_USE_PORTAL = "1";

      NIXOS_XDG_OPEN_USE_PORTAL = "1";
      NIX_XDG_DESKTOP_PORTAL_DIR = "/run/current-system/sw/share/xdg-desktop-portal/portals";

      XDG_SESSION_TYPE = "wayland";
      XDG_SCREENSHOTS_DIR = "/home/${username}/Pictures/Screenshots";

      # Conform more programs to XDG conventions. The rest are handled by their
      # respective modules.
      __GL_SHADER_DISK_CACHE_PATH = "$XDG_CACHE_HOME/nv";
      ASPELL_CONF = ''
        per-conf $XDG_CONFIG_HOME/aspell/aspell.conf;
        personal $XDG_CONFIG_HOME/aspell/en_US.pws;
        repl $XDG_CONFIG_HOME/aspell/en.prepl;
      '';
      CUDA_CACHE_PATH = "$XDG_CACHE_HOME/nv";
      HISTFILE = "$XDG_DATA_HOME/bash/history";
      INPUTRC = "$XDG_CONFIG_HOME/readline/inputrc";
      LESSHISTFILE = "$XDG_CACHE_HOME/lesshst";
      WGETRC = "$XDG_CONFIG_HOME/wgetrc";
      ANDROID_HOME = "$XDG_DATA_HOME/android";
      GRIPHOME = "$XDG_CONFIG_HOME/grip";
      PARALLEL_HOME = "$XDG_CONFIG_HOME/parallel";
    } // xdgConventions;
    sessionVariables = {
      XDG_DATA_DIRS = [
        "${pkgs.gsettings-desktop-schemas}/share"
        "${pkgs.nautilus}/share"
        "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}"
        "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
        "${pkgs.gtk4}/share/gsettings-schemas/${pkgs.gtk4.name}"
        "/home/${username}/.local/share:/usr/local/share:/usr/share"
        "/run/current-system/sw/share"
        "/var/lib/flatpak/exports/share"
        "$HOME/.local/share/flatpak/exports/share"
      ];
    } // xdgConventions;

    systemPackages = with pkgs; [
      xdg-launch
      xdg-utils # A set of command line tools that assist apps with a variety of desktop integration tasks
      xdg-user-dirs # Tool to help manage well known user directories like the desktop folder and the music folder
      xdg-dbus-proxy # DBus proxy for Flatpak and others
      xdg-desktop-portal # Desktop integration portals for sandboxed apps
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk # Desktop integration portals for sandboxed apps
      xdg-desktop-portal-hyprland
      desktop-file-utils
      libxdg_basedir # Implementation of the XDG Base Directory specification
      shared-mime-info # Database of common MIME types
      mime-types
    ];
  };


  xdg.menus.enable = true;
  xdg.icons.enable = true;
  xdg.autostart.enable = true;
  xdg.mime.enable = true;

  xdg.portal.enable = true;
  xdg.portal.wlr.enable = false; # disable wlr if using Hyprland
  xdg.portal.xdgOpenUsePortal = true;


  xdg.portal = {
    config = {
      common = {
        default = [ "*" ];
        "org.freedesktop.portal.Settings"   = [ "hyprland" ];
        "org.freedesktop.portal.ScreenCast" = [ "hyprland" ];
        "org.freedesktop.portal.Screenshot" = [ "hyprland" ];
        "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
        "org.freedesktop.impl.portal.FileChooser" = [ "hyprland" ];
        "org.freedesktop.portal.OpenURI"   = [ "hyprland" ];
      };
      hyprland = {
        default = [ "hyprland" ];
      };
    };

    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      # xdg-desktop-portal-hyprland
    ];
  };

  home-manager.users.${username} = {
    xdg = {
      enable = true;
      mime.enable = true;
      cacheHome = "/home/${username}/.cache";
      userDirs = {
        enable = true;
        createDirectories = true;
        templates = null;
        desktop = null;
        publicShare = null;
        extraConfig = {
          XDG_DOTFILES_DIR = "${settings.common.dotfilesDir}";
          XDG_BOOK_DIR = "/home/${username}/Books";
          XDG_SCREENSHOTS_DIR = "/home/${username}/Pictures/Screenshots";
        };
      };
      mimeApps.defaultApplications = associations;
    };
  };

  # xdg-desktop-portal works by exposing a series of D-Bus interfaces
  # known as portals under a well-known name
  # (org.freedesktop.portal.Desktop) and object path
  # (/org/freedesktop/portal/desktop).
  # The portal interfaces include APIs for file access, opening URIs, printing and others.
  services.dbus.enable = lib.mkDefault true;
}
