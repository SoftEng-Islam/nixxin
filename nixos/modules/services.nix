{ pkgs, ... }:
{
  services = {
    # fstrim.enable = true; # Whether to enable periodic SSD TRIM of mounted partitions in background.
    # tlp.enable = true;
    accounts-daemon.enable = true;
    dbus.implementation = "broker";
    devmon.enable = true;
    flatpak.enable = true;
    gvfs.enable = true;
    hostapd.enable = false;
    hypridle.enable = false; # Whether to enable hypridle, Hyprland’s idle daemon.
    libinput.mouse.accelSpeed = "-0.5"; # Enable touchpad support (enabled default in most desktopManager).
    openssh.enable = true; # Enable the OpenSSH daemon.
    power-profiles-daemon.enable = true;
    printing.enable = true; # Enable CUPS to print documents.
    resolved.enable = false; # systemd DNS resolver daemon, systemd-resolved.
    sysprof.enable = true; # Whether to enable sysprof profiling daemon.
    udisks2.enable = true; # Whether to enable udisks2, a DBus service that allows applications to query and manipulate storage devices.
    upower.enable = true; # Whether to enable Upower, a DBus service that provides power management support to applications.
    fwupd.enable = true; # Whether to enable fwupd, a DBus service that allows applications to update firmware.

    # logind
    logind.extraConfig = ''
      			HandlePowerKey=ignore
      			HandleLidSwitch=suspend
      			HandleLidSwitchExternalPower=ignore
      		'';

    displayManager.enable = true; # Whether to enable systemd’s display-manager service.
    # displayManager.sddm.enable = true; # Whether to enable sddm as the display manager.
    displayManager.defaultSession = "gnome"; # Set `gnome` or `hyprland` as the default session



    xserver = {
      # Enable the X11 windowing system.
      enable = true;
      # sysprof.enable = true;
      # printing.enable = true;
      # flatpak.enable = true;
      # openssh.enable = true;
      # Enable the GNOME Desktop Environment.
      displayManager = {
        # startx.enable = false; # No manual X sessions
        gdm.enable = true;
        gdm.wayland = true;
        # autoLogin.enable = true;
        # autoLogin.user = "softeng";
      };
      desktopManager = {
        gnome = {
          enable = true;
          # Specify GNOME GSettings overrides
          extraGSettingsOverrides = ''
            						[org.gnome.desktop.interface]
            						gtk-theme='Colloid-Dark'
            						icon-theme='Papirus-Dark'
            						color-scheme='prefer-dark'
            						cursor-theme='Breeze_Light'
            						cursor-size=24

            						[org.gnome.desktop.wm.preferences]
            						button-layout='close,minimize,maximize:'

            						[org.gnome.mutter]
            						check-alive-timeout=0
            					'';
        };
      };
      # Configure keymap in X11
      xkb = {
        layout = "us,ara";
        options = "grp:alt_shift_toggle";
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
