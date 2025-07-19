# Display/Login manager
{ settings, pkgs, ... }: {

  # Desktop Manager & Display Manager
  services.displayManager.enable = true;

  # ---- Set Default Session ---- #
  services.displayManager.defaultSession = "hyprland";

  # To Use SDDM
  # services.displayManager.sddm.enable = true;
  # services.displayManager.sddm.wayland.enable = true;

  # To Use GDM
  # services.displayManager.gdm.wayland = true;
  # services.displayManager.gdm.enable = true;
  # services.displayManager.gdm.autoSuspend = true;

  # ---- XSERVER ---- #
  services.xserver.enable = true;
  services.xserver.autorun = false;

  services.greetd = {
    enable = true;
    vt = 2;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd Hyprland";
        user = "greeter";
      };
    };
  };

  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal"; # Without this errors will spam on screen
    # Without these bootlogs will spam on screen
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };

  environment.systemPackages = with pkgs; [ gtk4 ];
}
