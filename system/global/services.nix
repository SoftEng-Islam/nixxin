{
  services = {
    # fstrim.enable = true; # Whether to enable periodic SSD TRIM of mounted partitions in background.
    # tlp.enable = true;
    accounts-daemon.enable = true;
    dbus.implementation = "broker";
    flatpak.enable = false;

    # Enable touchpad support (enabled default in most desktopManager).
    libinput.mouse.accelSpeed = "-0.5";

    # a DBus service that provides power management support to applications.
    upower.enable = true;
    # xserver.videoDrivers = [ "displaylink" "modesetting" ];

    openssh.enable = true; # Enable the OpenSSH daemon.
    power-profiles-daemon.enable = true;
    printing.enable = false; # Enable CUPS to print documents.
    sysprof.enable = false; # Whether to enable sysprof profiling daemon.

    # a DBus service that allows applications to update firmware.
    fwupd.enable = false;

    geoclue2.enable = true;
    colord.enable = true;

    # automount
    devmon.enable = true;
    udisks2.enable = true;
    # A lot of mpris packages require it.
    gvfs.enable = true;

    # logind
    logind.extraConfig = ''
      HandlePowerKey=ignore
      HandleLidSwitch=suspend
      HandleLidSwitchExternalPower=ignore
    '';

    displayManager = {
      enable = true; # Whether to enable systemd’s display-manager service.
      # sddm.enable = true; # Whether to enable sddm as the display manager.
      defaultSession =
        "gnome"; # Set `gnome` or `hyprland` as the default session
    };
  };
  #beesd = {
  #	enable = true;
  #	filesystems.btrfs = {
  #		# Example mount point for your Btrfs partition
  #		spec = "/mnt/btrfs";
  #		hashTableSizeMB = 1024; # 1GB hashtable size
  #	};
  #};
}
