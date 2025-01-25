{ settings, pkgs, ... }: {
  # Desktop Manager & Display Manager
  services = {
    displayManager.enable = true;
    # ---- Set Default Session ---- #    
    displayManager.defaultSession = settings.defaultSession;
    
    # ---- GREETED ---- #
    greetd.enable = false;
    greetd.settings.default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
          user = "greeter";
    };
    
    # ---- SDDM ---- #
    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;
    displayManager.sddm.package = pkgs.plasma5Packages.sddm;

    # ---- XSERVER ---- #
    xserver.enable = true;
  
    # ---- GDM ---- #
    xserver.displayManager.gdm.wayland = false;
    xserver.displayManager.gdm.enable = false;
        
    # ---- GNOME ---- #   
    # Enable or Disable the GNOME Desktop Environment.
    xserver.desktopManager.gnome.enable = settings.gnome.enable;
    
  };
}
