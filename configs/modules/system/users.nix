{ settings, pkgs, ... }: {
  users = {
    defaultUserShell = pkgs.zsh;
    groups.uinput.members = [ "${settings.username}" ];
    groups.input.members = [ "${settings.username}" ];
    users.${settings.username} = {
      isNormalUser = true;
      # isSystemUser = false;
      # hashedPassword = "";
      description = settings.name;
      home = "/home/${settings.username}";
      # shell = pkgs.zsh; # Set zsh as the default shell
      extraGroups = [
        "softeng"
        "adbusers"
        "gamemode"
        "adbusers"
        "audio" # Access to audio devices.
        "dialout"
        "disk"
        "transmission"
        "docker"
        "flatpak"
        "i2c"
        "input" # Access to input devices like keyboards and mice.
        "kvm"
        "libvirtd"
        "lp" # Manage printers.
        "network"
        "networkmanager" # Permissions to manage network connections.
        "plugdev"
        "qemu"
        "nixos"
        "render"
        "root"
        "tty"
        "sshd"
        "storage" # Access to storage devices.
        "uucp" # Access to serial ports and devices connected via serial ports.
        "vboxusers"
        "video" # Access to video devices
        "wheel" # Ability to use sudo for administrative tasks.
        "wireshark"
      ];
      uid = 1000;
      packages = with pkgs; [ thunderbird ];
    };
  };
  # services.getty.autologinUser = "softeng"; # Enable automatic login for the user.
}
