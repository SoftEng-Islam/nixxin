{ settings, pkgs, ... }: {
  imports = [
    # ./gdm.nix
    # ./greetd.nix
    # ./sddm.nix
    # ./tuigreet.nix
  ];
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
    displayManager.sddm.enable = false;
    displayManager.sddm.wayland.enable = false;
    displayManager.sddm.package = pkgs.plasma5Packages.sddm;

    # ---- XSERVER ---- #
    xserver.enable = true;

    # ---- GDM ---- #
    xserver.displayManager.gdm.wayland = true;
    xserver.displayManager.gdm.enable = true;

    # ---- GNOME ---- #
    # Enable or Disable the GNOME Desktop Environment.
    xserver.desktopManager.gnome.enable = settings.gnome.enable;

  };
}
