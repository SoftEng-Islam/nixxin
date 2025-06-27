# Display/Login manager
{ settings, lib, pkgs, ... }: {

  # Desktop Manager & Display Manager
  services.displayManager.enable = settings.modules.hyprland.dm.enable;

  # ---- Set Default Session ---- #
  services.displayManager.defaultSession =
    settings.modules.hyprland.dm.defaultSession;

#  services.displayManager.sddm.enable = true;
 # services.displayManager.sddm.wayland.enable = true;

   services.displayManager.gdm.wayland = true;
   services.displayManager.gdm.enable = true;
   services.displayManager.gdm.autoSuspend = true;

  # ---- XSERVER ---- #
  services.xserver.enable = true;
  services.xserver.autorun = false;
}
