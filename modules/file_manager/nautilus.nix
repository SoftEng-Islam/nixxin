{ settings, pkgs, lib, config, ... }:
let

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
  services.gvfs.enable = true;

  # thumbnails
  services.tumbler.enable = true;

  # systemd.user.services.nautilus = {
  #   description = "Keep Nautilus Running in Background";
  #   after = [ "graphical-session.target" ];
  #   wantedBy = [ "default.target" ];
  #   serviceConfig = {
  #     Type = "simple";
  #     ExecStart = "${pkgs.nautilus}/bin/nautilus --no-default-window";
  #     Restart = "always"; # Restart Nautilus if it crashes
  #     Environment = [
  #       "XDG_CURRENT_DESKTOP=Hyprland"
  #       "XDG_SESSION_TYPE=wayland"
  #       "DBUS_SESSION_BUS_ADDRESS=unix:path=%t/bus"
  #       "DISPLAY=:0"
  #     ];
  #   };
  # };

  home-manager.users.${settings.user.username} = {
    dconf.settings = {
      "org/gnome/nautilus/preferences" = {
        always-use-location-entry = true;
        show-create-link = true;
        show-delete-permanently = true;
      };

      # "small" or "small-plus" or "medium" or "large" or "extra-large"
      "org/gnome/nautilus/icon-view" = {
        default-zoom-level = settings.modules.styles.icons.icon_view_size;
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

  environment = {
    systemPackages = with pkgs; [
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
    pathsToLink = [ "/share/nautilus-python/extensions" ];
    sessionVariables = {
      FILE_MANAGER = "nautilus";

      NAUTILUS_4_EXTENSION_DIR =
        lib.mkDefault "${nautilus-env}/lib/nautilus/extensions-4";
    };
  };
}
