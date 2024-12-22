{ mySettings, pkgs, ... }: {
  users = {
    defaultUserShell = pkgs.zsh;
    users.${mySettings.username} = {
      isNormalUser = true;
      # isSystemUser = false;
      # hashedPassword = "";
      description = mySettings.name;
      home = "/home/${mySettings.username}";
      # shell = pkgs.zsh; # Set zsh as the default shell
      extraGroups = [
        "gamemode"
        "adbusers"
        "audio" # Access to audio devices.
        "dialout"
        "disk"
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
        "render"
        "root"
        "sshd"
        "storage" # Access to storage devices.
        "uucp" # Access to serial ports and devices connected via serial ports.
        "vboxusers"
        "video" # Access to video devices
        "wheel" # Ability to use sudo for administrative tasks.
        "wireshark"
      ];
      packages = with pkgs; [ thunderbird ];
    };
  };
  # services.getty.autologinUser = "softeng"; # Enable automatic login for the user.
}
