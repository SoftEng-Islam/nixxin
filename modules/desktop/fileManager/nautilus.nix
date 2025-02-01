{ pkgs, lib, config, ... }:
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
  environment = {
    systemPackages = with pkgs; [
      nautEnv

      file-roller
      gvfs # Mounts, trash, and remote filesystem support
      gvfs-afc # For Apple devices
      gvfs-gphoto2 # For cameras
      gvfs-mtp # For MTP devices like Android phones
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
