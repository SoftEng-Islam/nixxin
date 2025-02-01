{ pkgs, lib, config, ... }:
let
  nautEnv = pkgs.buildEnv {
    name = "nautilus-env";
    paths = with pkgs; [ nautilus nautilus-python nautilus-open-any-terminal ];
  };
in {
  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "kitty";
  };
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
      dconf
      file-roller
      gvfs # Mounts, trash, and remote filesystem support
      udisks2 # Disk mounting support
      tracker # File indexing for Nautilus search
      # xdg-desktop-portal-gnome

    ];
    pathsToLink = [ "/share/nautilus-python/extensions" ];
    sessionVariables = {
      FILE_MANAGER = "nautilus";
      NAUTILUS_EXTENSION_DIR =
        lib.mkDefault "${nautEnv}/lib/nautilus/extensions-4";
    };
  };
}
