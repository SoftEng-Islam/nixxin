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
        default = [ settings.modules.terminals.default.terminal.name ];
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

  programs.xfconf.enable = true;
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
      # thunar-dropbox-plugin
    ];
  };

  home-manager.users.${settings.user.username} = {
    home = {
      file = {
        ".local/share/nemo/actions/aunpack.nemo_action".text = ''
          [Nemo Action]
          Name=Extract here
          Comment=Extract the selected archive(s) using aunpack
          Exec=${pkgs.atool}/bin/aunpack -X %P %F
          Icon=package-x-generic
          Selection=Any
          Extensions=zip;tar;gz;bz2;7z;rar;
          Quote=double
        '';

        ".config/xfce4/xfconf/xfce-perchannel-xml/thunar.xml".text = ''
          <?xml version="1.0" encoding="UTF-8"?>

          <channel name="thunar" version="1.0">
            <property name="default-view" type="string" value="ThunarIconView"/>
            <property name="last-details-view-column-widths" type="string" value="50,50,118,111,50,50,50,50,993,50,50,84,50,151"/>
            <property name="last-details-view-zoom-level" type="string" value="THUNAR_ZOOM_LEVEL_38_PERCENT"/>
            <property name="last-icon-view-zoom-level" type="string" value="THUNAR_ZOOM_LEVEL_100_PERCENT"/>
            <property name="last-image-preview-visible" type="bool" value="false"/>
            <property name="last-location-bar" type="string" value="ThunarLocationButtons"/>
            <property name="last-menubar-visible" type="bool" value="false"/>
            <property name="last-separator-position" type="int" value="170"/>
            <property name="last-show-hidden" type="bool" value="false"/>
            <property name="last-side-pane" type="string" value="THUNAR_SIDEPANE_TYPE_SHORTCUTS"/>
            <property name="last-statusbar-visible" type="bool" value="false"/>
            <property name="last-toolbar-item-order" type="string" value="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17"/>
            <property name="last-toolbar-items" type="string" value="menu:1,undo:1,back:1,forward:1,open-parent:0,open-home:0,redo:0,zoom-in:0,zoom-out:0,zoom-reset:0,location-bar:1,view-switcher:1,search:1,view-as-icons:0,view-as-detailed-list:0,view-as-compact-list:0,toggle-split-view:0,reload:0,new-tab:0,new-window:0,uca-action-1700000000000001:0"/>
            <property name="last-toolbar-visible-buttons" type="string" value="0,1,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0"/>
            <property name="last-view" type="string" value="ThunarIconView"/>
            <property name="last-window-maximized" type="bool" value="true"/>
            <property name="misc-change-window-icon" type="bool" value="true"/>
            <property name="misc-date-style" type="string" value="THUNAR_DATE_STYLE_SIMPLE"/>
            <property name="misc-file-size-binary" type="bool" value="true"/>
            <property name="misc-full-path-in-tab-title" type="bool" value="true"/>
            <property name="misc-open-new-window-as-tab" type="bool" value="false"/>
            <property name="misc-show-delete-action" type="bool" value="false"/>
            <property name="misc-single-click" type="bool" value="false"/>
            <property name="misc-symbolic-icons-in-sidepane" type="bool" value="false"/>
            <property name="misc-symbolic-icons-in-toolbar" type="bool" value="false"/>
            <property name="misc-text-beside-icons" type="bool" value="false"/>
            <property name="misc-thumbnail-draw-frames" type="bool" value="false"/>
            <property name="misc-thumbnail-max-file-size" type="uint64" value="1073741824"/>
            <property name="misc-use-csd" type="bool" value="true"/>
            <property name="shortcuts-icon-emblems" type="bool" value="true"/>
            <property name="shortcuts-icon-size" type="string" value="THUNAR_ICON_SIZE_48"/>
            <property name="tree-icon-emblems" type="bool" value="true"/>
            <property name="tree-icon-size" type="string" value="THUNAR_ICON_SIZE_48"/>

            <property name="hidden-bookmarks" type="array">
              # <value type="string" value="computer:///"/>
              # <value type="string" value="recent:///"/>
              <value type="string" value="file:///"/>
              # <value type="string" value="network:///"/>
            </property>
            <property name="hidden-devices" type="array">
              # <value type="string" value=""/>
            </property>
          </channel>
        '';

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
        xfce.thunar
        xfce.xfconf
        xfce.tumbler
        xfce.thunar-archive-plugin
        xfce.thunar-volman
        xfce.thunar-media-tags-plugin
        p7zip
        xarchiver
        papirus-icon-theme
        material-icons
        material-design-icons
        material-symbols
      ];
      sessionVariables = {
        XDG_ICON_DIR = "${pkgs.papirus-icon-theme}/share/icons/${settings.common.icons.nameInDark}";
        QS_ICON_THEME = settings.common.icons.nameInDark;
        QT_STYLE_OVERRIDE = lib.mkForce "Fusion";
      };
    };
    xdg.configFile."Thunar/uca.xml".text = ''
      <?xml version="1.0" encoding="UTF-8"?>
      <actions>
        <action>
            <icon>utilities-terminal</icon>
            <name>Open Terminal Here</name>
            <unique-id>1700000000000001</unique-id>
            <command>${settings.modules.terminals.default.terminal.name}</command>
            <description>Opens ${settings.modules.terminals.default.terminal.name} terminal in the selected folder</description>
            <patterns>*</patterns>
            <startup-notify/>
            <directories/>
        </action>
        <action>
            <icon></icon>
            <name>Extract here</name>
            <submenu></submenu>
            <unique-id>1689618425925956-3</unique-id>
            <command>xarchiver -x . %f</command>
            <description>Extracts the archive into the directory it is located in.</description>
            <range>*</range>
            <patterns>*.tar.bz2;*.tar.gz;*.tar.xz;*.tar.Z;*.tar;*.taz;*.tb2;*.tbz;*.tbz2;*.tgz;*.txz;*.zip;*.bz2;*.docx;*.apk;*.gz;*.odt;</patterns>
            <other-files/>
        </action>
        <action>
          <icon>package-x-generic</icon>
          <name>Compress here (tar.gz)</name>
          <submenu></submenu>
          <unique-id>1700000000000003</unique-id>
          <command>tar -czvf %n.tar.gz %N</command>
          <description>Creates a compressed archive (.tar.gz) of selected files/folders.</description>
          <range>*</range>
          <patterns>*</patterns>
          <directories/>
          <other-files/>
        </action>
      </actions>
    '';
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

    atool
  ];
}
