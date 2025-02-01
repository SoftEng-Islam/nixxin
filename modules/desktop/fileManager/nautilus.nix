{ settings, pkgs, lib, config, ... }:
let
  nautEnv = pkgs.buildEnv {
    name = "nautilus-env";
    paths = with pkgs; [ nautilus nautilus-python nautilus-open-any-terminal ];
  };
in {
  programs = {
    nautilus-open-any-terminal = {
      enable = true;
      terminal = "kitty";
    };
    # Required by gnome file managers
    file-roller.enable = true;
    gnome-disks.enable = true;
  };
  # ---- Tracker3 ---- #
  services.gnome.tinysparql.enable = true; # indexing files
  services.gnome.localsearch.enable = true;
  services.udisks2.enable = true;
  services.gvfs.enable = true;

  systemd.user.services.nautilus = {
    description = "Preload Nautilus";
    after = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.nautilus}/bin/nautilus --no-desktop";
      Restart = "always";
    };
    wantedBy = [ "default.target" ];
  };

  home-manager.users."${settings.users.selected.username}" = {
    dconf.settings = {
      "org/gnome/nautilus/preferences" = {
        always-use-location-entry = true;
        show-create-link = true;
        show-delete-permanently = true;
      };

      "org/gnome/nautilus/icon-view" = { default-zoom-level = "small-plus"; };

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
      nautEnv

      file-roller
      gvfs # Mounts, trash, and remote filesystem support
      udisks2 # Disk mounting support

      # tracker # File indexing for Nautilus search
      tinysparql

      xdg-desktop-portal-gnome
    ];
    pathsToLink = [ "/share/nautilus-python/extensions" ];
    sessionVariables = {
      FILE_MANAGER = "nautilus";
      NAUTILUS_EXTENSION_DIR =
        lib.mkDefault "${nautEnv}/lib/nautilus/extensions-4";
    };
  };
}
