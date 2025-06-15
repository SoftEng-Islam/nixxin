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
  xdg = settings.modules.xdg;
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

in mkIf (xdg.enable) {
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
      # Don't set this var
      # XDG_CURRENT_DESKTOP = "Hyprland"; #"GNOME" or "Hyprland";

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
      # used by `gio open` and xdp-gtk
      (pkgs.writeShellScriptBin "xdg-terminal-exec" ''
        ${settings.terminals.default.terminal.name} "$@"
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
      mime-types
    ];
  };

  xdg = {
    portal = {
      enable = true;
      wlr.enable = true;
      xdgOpenUsePortal = true;
      config = {
        common = {
          default = [ "*" ]; # "*" or "gtk"
          "org.freedesktop.portal.Settings" = [ "gtk" ];
          "org.freedesktop.portal.ScreenCast" = [ "hyprland" ];
          "org.freedesktop.portal.Screenshot" = [ "hyprland" ];
          "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
          "org.freedesktop.impl.portal.FileChooser" = [ "nautilus" ];
        };
        hyprland = { default = [ "hyprland" ]; };
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

  home-manager.users.${username} = {
    xdg = {
      enable = true;
      mime.enable = true;
      # icons.enable = true;
      # configFile."gtk-4.0/gtk.css".enable = lib.mkForce true;
      cacheHome = "$HOME/.cache";
      userDirs = {
        enable = true;
        createDirectories = true;
        music = "/home/${username}/Music";
        videos = "/home/${username}/Videos";
        pictures = "/home/${username}/Pictures";
        download = "/home/${username}/Downloads";
        documents = "/home/${username}/Documents";
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
          XDG_BOOK_DIR = "/home/${username}/Books";
          XDG_SCREENSHOTS_DIR = "/home/${username}/Pictures/Screenshots";
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
}
