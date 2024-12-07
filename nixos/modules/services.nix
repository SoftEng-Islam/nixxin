{
  services = {
    # fstrim.enable = true; # Whether to enable periodic SSD TRIM of mounted partitions in background.
    # tlp.enable = true;
    accounts-daemon.enable = true;
    dbus.implementation = "broker";
    devmon.enable = true;
    flatpak.enable = false;
    gvfs.enable = true;
    libinput.mouse.accelSpeed =
      "-0.5"; # Enable touchpad support (enabled default in most desktopManager).
    openssh.enable = true; # Enable the OpenSSH daemon.
    power-profiles-daemon.enable = true;
    printing.enable = false; # Enable CUPS to print documents.
    sysprof.enable = false; # Whether to enable sysprof profiling daemon.
    udisks2.enable =
      true; # a DBus service that allows applications to query and manipulate storage devices.
    upower.enable =
      true; # a DBus service that provides power management support to applications.
    fwupd.enable =
      false; # a DBus service that allows applications to update firmware.
    geoclue2.enable = true;
    colord.enable = true;

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

    xserver = {
      enable = true;
      displayManager = {
        gdm.enable = true;
        gdm.wayland = true;
      };
      videoDrivers = [ "amdgpu" ];
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
