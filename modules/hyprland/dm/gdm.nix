{ ... }: {
  services.displayManager.gdm.wayland = false;
  services.displayManager.gdm.enable = false;
  services.displayManager.gdm.autoSuspend = false;
}
