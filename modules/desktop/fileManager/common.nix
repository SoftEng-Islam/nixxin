{
  settings,
  lib,
  pkgs,
  ...
}:
let
  fm_settings = settings.modules.desktop.file_manager;
in
{
  # Required by gnome file managers
  programs.gnome-disks.enable = true;

  services.tumbler.enable = true; # thumbnailer service for nautilus and thunar

  services.udisks2.enable = true;
  services.devmon.enable = true;
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.gvfs.package = pkgs.gnome.gvfs;

  # helps with GIO-based file access
  services.gnome.glib-networking.enable = true;

  services.dbus.packages = with pkgs; [
    libcryptui
  ];

  services.desktopManager.gnome.extraGSettingsOverridePackages = with pkgs; [
    gcr
    libcryptui
  ];

  xdg = {
    # fix opening terminal for nemo / thunar by using xdg-terminal-exec spec
    terminal-exec = {
      enable = true;
      settings = {
        default = [ settings.modules.terminals.default.terminal.name ];
      };
    };
    # fix mimetype associations
    mime.defaultApplications = {
      "inode/directory" = "${fm_settings.default}.desktop";
      # wtf zathura / pqiv registers themselves to open archives
      "application/zip" = "org.gnome.FileRoller.desktop";
      "application/vnd.rar" = "org.gnome.FileRoller.desktop";
      "application/x-7z-compressed" = "org.gnome.FileRoller.desktop";
      "application/x-bzip2-compressed-tar" = "org.gnome.FileRoller.desktop";
      "application/x-tar" = "org.gnome.FileRoller.desktop";
    };
  };

  home-manager.users.${settings.user.username} = {
    home = {
      file = {
        ".config/xarchiver/xarchiverrc".text = ''
          [xarchiver]
          preferred_format=0
          prefer_unzip=true
          confirm_deletion=true
          sort_filename_content=true
          advanced_isearch=true
          auto_expand=true
          store_output=true
          icon_size=2
          show_archive_comment=false
          show_sidebar=true
          show_location_bar=true
          show_toolbar=true
          preferred_custom_cmd=
          preferred_temp_dir=/tmp
          preferred_extract_dir=/home/${settings.user.username}/Downloads
          allow_sub_dir=0
          ensure_directory=true
          overwrite=false
          full_path=2
          touch=false
          fresh=false
          update=false
          store_path=false
          updadd=true
          freshen=false
          recurse=true
          solid_archive=false
          remove_files=false
        '';
      };
      packages = with pkgs; [
        p7zip
        xarchiver
      ];
      sessionVariables = {
        QS_ICON_THEME = settings.common.icons.nameInDark;
        QT_STYLE_OVERRIDE = lib.mkForce "Fusion";
      };
    };
    programs.dircolors = {
      enable = true;
    };
    dconf.settings = {
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

    # Daemon, tools and libraries to access and manipulate disks, storage devices and technologies
    udisks

    # Thumbnails
    gst_all_1.gst-libav
    ffmpegthumbnailer

    atool
  ];
}
