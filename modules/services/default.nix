{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in {
  imports = [ ./toggle-services.nix ];
  services = {
    # Tumbler, A D-Bus thumbnailer service.
    tumbler.enable = true;

    # ACPI daemon
    acpid.enable = true;

    # Populates contents of /bin and /usr/bin/
    envfs.enable = true;

    # Enable touchpad support (enabled default in most desktopManager).
    libinput.mouse.accelSpeed = "-0.5";

    # The color management daemon.
    colord.enable = true;

    # An automatic device mounting daemon.
    devmon.enable = true;

    # A DBus service that provides location information for accessing.
    geoclue2.enable = true;

    # A userspace virtual filesystem.
    gvfs.enable = true; # A lot of mpris packages require it.

    # Printing support through the CUPS daemon.
    printing.enable = false; # Enable CUPS to print documents.

    # sysprof profiling daemon.
    sysprof.enable = true; # Whether to enable sysprof profiling daemon.

    logind.extraConfig = ''
      # don’t shutdown when power button is short-pressed
      HandlePowerKey=ignore
    '';
  };
}
