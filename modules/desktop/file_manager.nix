{ settings, lib, pkgs, ... }:
let
  _file_manager = settings.modules.file_manager;
  # inherit (lib) mkIf;
  _pkgs = with pkgs; [ (lib.optional _file_manager.spacedrive spacedrive) ];

  # find /nix/store -name "*nautilus-env*"
  # tree -L 2 /nix/store/xxxxxxxxxxxxxxxxx-nautilus-env
  nautilus-env = pkgs.buildEnv {
    name = "nautilus-env";
    paths = with pkgs; [
      (pkgs.writeShellScriptBin "nautilus" ''
        export GST_PLUGIN_PATH_1_0="/run/current-system/sw/lib/gstreamer-1.0"
        export GST_PLUGIN_SYSTEM_PATH_1_0="${pkgs.gst_all_1.gstreamer}/lib/gstreamer-1.0:${pkgs.gst_all_1.gst-libav}/lib/gstreamer-1.0:${pkgs.gst_all_1.gst-vaapi}/lib/gstreamer-1.0:${pkgs.gst_all_1.gst-plugins-base}/lib/gstreamer-1.0:${pkgs.gst_all_1.gst-plugins-good}/lib/gstreamer-1.0:${pkgs.gst_all_1.gst-plugins-bad}/lib/gstreamer-1.0:${pkgs.gst_all_1.gst-plugins-ugly}/lib/gstreamer-1.0:${pkgs.gst_all_1.gst-plugins-rs}/lib/gstreamer-1.0:${pkgs.pipewire}/lib/gstreamer-1.0:${pkgs.pulseeffects-legacy}/lib/gstreamer-1.0"
        exec ${pkgs.nautilus}/bin/nautilus "$@"
      '')
      nautilus-python
      nautilus-open-any-terminal
    ];
  };
in {
  # nautilus-open-any-terminal
  programs.nautilus-open-any-terminal.enable = true;
  programs.nautilus-open-any-terminal.terminal =
    settings.modules.terminals.default.terminal.name;

  # Required by gnome file managers
  programs.file-roller.enable = true;
  programs.gnome-disks.enable = true;

  # ---- Tracker3 ---- #
  services.gnome.tinysparql.enable = true; # indexing files
  services.gnome.localsearch.enable = true;
  services.udisks2.enable = true;
  services.devmon.enable = true;
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.gvfs.package = pkgs.gnome.gvfs;

  # thumbnails
  services.tumbler.enable = true;

  home-manager.users.${settings.user.username} = {
    programs.dircolors = { enable = true; };
    dconf.settings = {
      "org/gnome/nautilus/preferences" = {
        always-use-location-entry = true;
        show-create-link = true;
        show-delete-permanently = true;
      };

      # "small" or "small-plus" or "medium" or "large" or "extra-large"
      "org/gnome/nautilus/icon-view" = {
        default-zoom-level = settings.modules.dconf.icons.icon_view_size;
      };

      "org/gtk/gtk4/settings/file-chooser" = {
        sort-directories-first = true;
        show-hidden = true;
      };
    };

    home.file = {
      "Templates/new".text = "";
      "Templates/new.cfg".text = "";
      "Templates/new.ini".text = "";
      "Templates/new.sh".text = "";
      "Templates/new.txt".text = "";
    };
  };

  environment.pathsToLink = [ "/share/nautilus-python/extensions" ];
  environment.sessionVariables.FILE_MANAGER = "nautilus";
  environment.sessionVariables.NAUTILUS_4_EXTENSION_DIR =
    lib.mkDefault "${nautilus-env}/lib/nautilus/extensions-4";

  environment.systemPackages = with pkgs;
    lib.flatten _pkgs ++ [

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

      unzip # An extraction utility for archives compressed in .zip format
      zip # Compressor/archiver for creating and modifying zipfiles
      xz

      # Our File Manager
      nautilus-env

      # Collection of GSettings schemas for settings shared by various components of a desktop
      gsettings-desktop-schemas

      # Archive manager for the GNOME desktop environment
      file-roller

      # Mounts, trash, and remote filesystem support
      gvfs

      # Daemon, tools and libraries to access and manipulate disks, storage devices and technologies
      udisks
      udisks2 # Disk mounting support

      # Desktop-neutral user information store, search tool and indexer
      tinysparql

      # Quick previewer for Nautilus
      sushi

      # Graphical interface for version control intended to run on gnome and nautilus
      turtle

      # File indexing for Nautilus search
      # tracker

      # Backend implementation for xdg-desktop-portal for the GNOME desktop environment
      xdg-desktop-portal-gnome

      # A really easy way to scan both documents and photos.
      simple-scan

      # thumbnails
      gst_all_1.gst-libav
      ffmpegthumbnailer

    ];
}
