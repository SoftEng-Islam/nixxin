{ pkgs, ... }: {
  users = {
    defaultUserShell = pkgs.zsh;
    users.softeng = {
      isNormalUser = true;
      description = "Nixos Admin";
      # shell = pkgs.zsh; # Set zsh as the default shell
      extraGroups = [
        "root"
        "wheel" # Ability to use sudo for administrative tasks.
        "input" # Access to input devices like keyboards and mice.
        "audio" # Access to audio devices.
        "render"
        "video" # Access to video devices
        "i2c"
        "disk"
        "sshd"
        "storage" # Access to storage devices.
        "uucp" # Access to serial ports and devices connected via serial ports.
        "lp" # Manage printers.
        "flatpak"
        "network"
        "networkmanager" # Permissions to manage network connections.
        "qemu"
        "kvm"
        "libvirtd"
      ];
      packages = with pkgs; [ thunderbird ];
    };
  };
  # services.getty.autologinUser = "softeng"; # Enable automatic login for the user.
}
