{
  settings,
  lib,
  pkgs,
  ...
}:
{

  # https://nixos.wiki/wiki/Nautilus
  # Nautilus stores “recent files” in:
  # ~/.local/share/recently-used.xbel

  # Required by gnome file managers
  programs.gnome-disks.enable = true;

  services.tumbler.enable = true; # thumbnailer service for nauitlus

  # ---- Tracker3 ---- #
  services.gnome.tinysparql.enable = true; # indexing files
  services.gnome.localsearch.enable = true;
  services.udisks2.enable = true;
  services.devmon.enable = true;
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.gvfs.package = pkgs.gnome.gvfs;

  nixpkgs.overlays = [
    (self: super: {
      gnome = super.gnome.overrideScope (
        gself: gsuper: {
          nautilus = gsuper.nautilus.overrideAttrs (nsuper: {
            buildInputs =
              nsuper.buildInputs
              ++ (with pkgs; [
                gst_all_1.gst-plugins-good
                gst_all_1.gst-plugins-bad
                gst_all_1.gst-plugins-base
                gst_all_1.gstreamer
                gst_all_1.gst-libav
              ]);
          });
        }
      );
    })
  ];

  xdg = {
    # fix opening terminal for nemo / thunar by using xdg-terminal-exec spec
    terminal-exec = {
      enable = true;
      settings = {
        default = [ settings.common.terminal.name ];
      };
    };
    # fix mimetype associations
    mime.defaultApplications = {
      "inode/directory" = "nemo.desktop";
      # wtf zathura / pqiv registers themselves to open archives
      "application/zip" = "org.gnome.FileRoller.desktop";
      "application/vnd.rar" = "org.gnome.FileRoller.desktop";
      "application/x-7z-compressed" = "org.gnome.FileRoller.desktop";
      "application/x-bzip2-compressed-tar" = "org.gnome.FileRoller.desktop";
      "application/x-tar" = "org.gnome.FileRoller.desktop";
    };
  };

  home-manager.users.${settings.user.username} = {
    programs.dircolors = {
      enable = true;
    };
    dconf.settings = {
      "org/gnome/nautilus/preferences" = {
        always-use-location-entry = true;
        default-folder-viewer = "icon-view"; # "icon-view", "list-view"
        migrated-gtk-settings = true;
        search-filter-time-type = "last_modified";
        search-view = "list-view";
        show-create-link = true;
        show-delete-permanently = true;
        show-hidden = false;
        sort-directories-first = true;
      };
      "org/gnome/nautilus/list-view" = {
        default-column-order = [
          "name"
          "size"
          "type"
          "owner"
          "group"
          "permissions"
          "where"
          "date_modified"
          "date_modified_with_time"
          "date_accessed"
          "recency"
          "starred"
          "detailed_type"
        ];
        default-visible-columns = [
          "name"
          "size"
          "type"
          "owner"
        ];
      };

      # "small" or "small-plus" or "medium" or "large" or "extra-large"
      "org/gnome/nautilus/icon-view" = {
        default-zoom-level = settings.modules.desktop.dconf.icons.icon_view_size;
      };

      "org/nemo/preferences" = {
        click-double-parent-folder = true;
        click-policy = "single";
        show-hidden-files = true;
        size-prefixes = "base-2";
        thumbnail-limit = "68719476735";
      };

      "org/gtk/gtk4/settings/file-chooser" = {
        sort-directories-first = true;
        show-hidden = false;
      };

      "org/gtk/settings/file-chooser" = {
        sidebar-width = 217;
        sort-column = "type";
        sort-directories-first = true;
        sort-order = "ascending";
        type-format = "category";
        window-position = "(104, 104)";
        window-size = "(1231, 902)";
        date-format = "regular";
        location-mode = "path-bar";
        show-hidden = false;
        show-size-column = true;
        show-type-column = true;
        view-type = "list";
      };
    };
  };

  # helps with GIO-based file access
  services.gnome.glib-networking.enable = true;

  services.dbus.packages = with pkgs; [
    libcryptui
  ];

  services.desktopManager.gnome.extraGSettingsOverridePackages = with pkgs; [
    nemo
    gcr
    libcryptui
    nemo-seahorse
  ];

  # environment.pathsToLink = [ "/share/nautilus-python/extensions" ];
  environment.sessionVariables.FILE_MANAGER = "nautilus";
  # environment.sessionVariables.NAUTILUS_4_EXTENSION_DIR = lib.mkDefault "${nautilus-env}/lib/nautilus/extensions-4";

  environment.systemPackages = with pkgs; [
    nautilus

    # Thunar
    xfce.thunar

    # File browser for Cinnamon
    nemo
    nemo-emblems
    nemo-fileroller
    nemo-preview
    nemo-python
    nemo-qml-plugin-dbus

    (nemo-with-extensions.override {
      extensions = [ nemo-seahorse ];
    })

    kdePackages.dolphin
    kdePackages.dolphin-plugins

    file # A program that shows the type of files
    lsof # Tool to list open files
    patool # portable archive file manager
    rsync # Fast incremental file transfer utility

    # CLI programs required by file-roller
    _7zz
    binutils

    # archives
    p7zip

    # unrar # Utility for RAR archives
    # unrar-free # Free utility to extract files from RAR archives
    # unar # Archive unpacker program
    unrar-wrapper # Backwards compatibility between unar and unrar
    rar # Utility for RAR archives

    gzip
    unzip # An extraction utility for archives compressed in .zip format
    zip # Compressor/archiver for creating and modifying zipfiles
    xz

    # Collection of GSettings schemas for settings shared by various components of a desktop
    gsettings-desktop-schemas

    # Archive manager for the GNOME desktop environment
    file-roller

    # Mounts, trash, and remote filesystem support
    gvfs

    # Daemon, tools and libraries to access and manipulate disks, storage devices and technologies
    udisks
    # udisks2 # Disk mounting support

    # Desktop-neutral user information store, search tool and indexer
    tinysparql

    # Thumbnails
    gst_all_1.gst-libav
    ffmpegthumbnailer
  ];
}
