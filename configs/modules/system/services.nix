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

    # populates contents of /bin and /usr/bin/
    envfs.enable = true;

    # Enable touchpad support (enabled default in most desktopManager).
    libinput.mouse.accelSpeed = "-0.5";

    colord.enable = true;
    devmon.enable = true;
    flatpak.enable = false;
    geoclue2.enable = true;
    gvfs.enable = true; # A lot of mpris packages require it.
    printing.enable = false; # Enable CUPS to print documents.
    sysprof.enable = true; # Whether to enable sysprof profiling daemon.

    logind.extraConfig = ''
      # don’t shutdown when power button is short-pressed
      HandlePowerKey=ignore
    '';
  };
}
