{ settings, lib, pkgs, ... }: {

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

  nixpkgs.overlays = [
    (final: prev: {
      __dontExport = true; # avoids polluting package set

      gnome = prev.gnome // {
        nautilus = prev.gnome.nautilus.overrideAttrs (old: rec {
          preFixup = with prev;
            let py = python3.withPackages (ps: with ps; [ ps.pygobject3 ]);
            in ''
              gappsWrapperArgs+=(
                # Thumbnailers
                --prefix XDG_DATA_DIRS : "${gdk-pixbuf}/share"
                --prefix XDG_DATA_DIRS : "${librsvg}/share"
                --prefix XDG_DATA_DIRS : "${shared-mime-info}/share"

                # Python bindings for Nautilus extensions
                --prefix PYTHONPATH : ${py}/${py.sitePackages}
              )
            '';
        });
      };
    })
  ];

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
        default-zoom-level =
          settings.modules.desktop.dconf.icons.icon_view_size;
      };

      "org/gtk/gtk4/settings/file-chooser" = {
        sort-directories-first = true;
        show-hidden = true;
      };
    };
  };

  # helps with GIO-based file access
  services.gnome.glib-networking.enable = true;

  # environment.pathsToLink = [ "/share/nautilus-python/extensions" ];
  environment.sessionVariables.FILE_MANAGER = "nautilus";
  # environment.sessionVariables.NAUTILUS_4_EXTENSION_DIR = lib.mkDefault "${nautilus-env}/lib/nautilus/extensions-4";

  environment.systemPackages = with pkgs; [

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

    nautilus

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

    # thumbnails
    gst_all_1.gst-libav
    ffmpegthumbnailer

  ];
}
