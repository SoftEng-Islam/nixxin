{ settings, pkgs, ... }: {
  # Desktop Manager & Display Manager
  services = {
    xserver = {
      enable = true;
      # displayManager.startx.enable = false;
      displayManager.sddm.enable = true; # x11

      # Enable the GNOME Desktop Environment.
      desktopManager.gnome.enable = settings.gnome.enable;
    };
    displayManager.enable = true;
    displayManager.defaultSession = settings.defaultSession;
  };
}
