{ settings, pkgs, ... }: {
  system = {
    autoUpgrade.enable = settings.system.upgrade.enable;
    autoUpgrade.allowReboot = settings.system.upgrade.allowReboot;
    autoUpgrade.channel = settings.system.upgrade.channel;
    stateVersion = settings.system.stateVersion;
  };
  #additional impermanence directories
  environment.persistence."/persist".directories = [
    "/var/lib/bluetooth"
    "/etc/NetworkManager/system-connections"
    "/var/lib/waydroid"
    "/var/lib/libvirt"
    "/etc/secureboot"
    "/var/cache/nixseparatedebuginfod" # to stop nixseparatedebuginfod to re-index at every reboot
  ];
}
