{ settings, pkgs, ... }: {
  users = {
    defaultUserShell = pkgs.zsh;
    groups.uinput.members = [ "${settings.users.selected.username}" ];
    groups.input.members = [ "${settings.users.selected.username}" ];
    users.${settings.users.selected.username} = {
      isNormalUser = true;
      # isSystemUser = false;
      # hashedPassword = "";
      description = settings.users.selected.name;
      home = "/home/${settings.users.selected.username}";
      # shell = pkgs.zsh; # Set zsh as the default shell
      extraGroups = [
        "adbusers"
        "audio" # Access to audio devices.
        "dialout"
        "disk"
        "docker"
        "flatpak"
        "gamemode"
        "i2c"
        "input" # Access to input devices like keyboards and mice.
        "kvm"
        "libvirtd"
        "lp" # Manage printers.
        "network"
        "networkmanager" # Permissions to manage network connections.
        "nixos"
        "plugdev"
        "qemu"
        "render"
        "root"
        "softeng"
        "sshd"
        "storage" # Access to storage devices.
        "transmission"
        "tty"
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
