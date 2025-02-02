{ settings, pkgs, ... }: {
  services.xserver = {
    enable = true;
    displayManager.gdm = {
      enable = true;
      autoSuspend = false;
    };

    xkb.layout = "us,eg";
  };
  # Workaround for autologin
  systemd.services = {
    "getty@tty1".enable = false;
    "autovt@tty1".enable = false;
  };
}
