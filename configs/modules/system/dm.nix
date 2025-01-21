{ settings, pkgs, ... }: {
  # Desktop Manager & Display Manager
  services = {
    # displayManager.sddm.enable = true;
    xserver = {
      enable = true;
      # Enable the GNOME Desktop Environment.
      desktopManager.gnome.enable = settings.gnome.enable;
    };
    displayManager.enable = true;
    displayManager.defaultSession = settings.defaultSession;
  };
}
