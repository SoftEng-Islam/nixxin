{ settings, pkgs, ... }: {
  users = {
    defaultUserShell = pkgs.zsh;
    groups.uinput.members = [ "${settings.user.username}" ];
    groups.input.members = [ "${settings.user.username}" ];
    # Ensure user is in the i2c and video groups for ddcutil
    groups.i2c.members = [ "${settings.user.username}" ];
    groups.video.members = [ "${settings.user.username}" ];

    users.${settings.user.username} = {

      isNormalUser = true;
      # isSystemUser = false;

      # To generate a hashed password run `mkpasswd`.
      hashedPassword =
        "$y$j9T$5HywFRGm/t.0VjspGLm8./$GtocDydBdCVWhVq8XaZnIUWUebqMQsS5rjJp7tSsRW/";

      description = settings.user.name;
      home = "/home/${settings.user.username}";

      shell = pkgs.zsh; # Set zsh as the default shell

      extraGroups = [
        "adbusers"
        "audio" # Access to audio devices.
        "colord"
        "corectrl"
        "dialout"
        "disk"
        "docker"
        "fuse"
        "gamemode"
        "i2c"
        "input" # Access to input devices like keyboards and mice.
        "kvm"
        # "libvirtd"
        "lp" # Manage printers.
        "lxd"
        "network"
        "networkmanager" # Permissions to manage network connections.
        "plugdev"
        "polkitd" # Ensures proper permission handling
        "qemu"
        "realtime" # Allows setting low-latency priority for audio
        "render"
        "rtkit" # Required for PipeWire's real-time scheduling
        "storage" # Access to storage devices.
        "systemd-resolve"
        "transmission"
        "tty"
        "uucp" # Access to serial ports and devices connected via serial ports.
        "vboxusers"
        "video" # Access to video devices
        "waydroid"
        "wheel" # Ability to use sudo for administrative tasks.
        "wireshark"
        "sambashare"
        "${settings.user.username}"
      ];
      uid = 1000;
      packages = with pkgs; [ thunderbird ];
    };
  };
}
