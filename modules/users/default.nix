{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in {
  users = {
    defaultUserShell = pkgs.zsh;
    groups.uinput.members = [ "${settings.user.username}" ];
    groups.input.members = [ "${settings.user.username}" ];
    users.${settings.user.username} = {
      isNormalUser = true;
      # isSystemUser = false;
      # hashedPassword = "";
      description = settings.user.name;
      home = "/home/${settings.user.username}";
      # shell = pkgs.zsh; # Set zsh as the default shell
      extraGroups = [
        "adbusers"
        "audio" # Access to audio devices.
        "colord"
        "corectrl"
        "dialout"
        "disk"
        "docker"
        "flatpak"
        "fuse"
        "gamemode"
        "i2c"
        "input" # Access to input devices like keyboards and mice.
        "kvm"
        "libvirtd"
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
        "softeng"
        # "nixos"
        # "root"
        # "sshd"
      ];
      uid = 1000;
      # packages = with pkgs; [ thunderbird ];
    };
  };
}
