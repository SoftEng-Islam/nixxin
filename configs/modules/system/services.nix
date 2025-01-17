{ settings, pkgs, ... }: {
  # ~~~~~~~~~~~~~~~~~~~~~~~~
  # ~~~~~~~ Services ~~~~~~~
  # ~~~~~~~~~~~~~~~~~~~~~~~~
  services = {
    tumbler.enable = true;
    acpid.enable = true;

    seatd.enable = true;
    # seatd.user = "root";
    # services.seatd.group = "seat";

    # disable NetworkManager-wait-online.service

    # xserver.excludePackages = with pkgs; [ xterm ];
    xserver = {
      enable = true;
      displayManager.startx.enable = true;
      displayManager.gdm.enable = true; # x11
      displayManager.gdm.wayland = true; # wayland
      desktopManager.gnome = {
        enable = true;
        extraGSettingsOverridePackages = [ pkgs.nautilus-open-any-terminal ];
      };
    };
    # Enable the GNOME Desktop Environment.
    displayManager.enable = true;
    displayManager.defaultSession = settings.defaultSession;

    # populates contents of /bin and /usr/bin/
    envfs.enable = true;
    accounts-daemon.enable = true;

    # Enable touchpad support (enabled default in most desktopManager).
    libinput.mouse.accelSpeed = "-0.5";

    colord.enable = true;
    devmon.enable = true;
    flatpak.enable = false;
    fwupd.enable = false;
    geoclue2.enable = true;
    gvfs.enable = true; # A lot of mpris packages require it.
    openssh.enable = true; # Enable the OpenSSH daemon.
    printing.enable = false; # Enable CUPS to print documents.
    sysprof.enable = false; # Whether to enable sysprof profiling daemon.
    udisks2.enable = true;
  };
}
