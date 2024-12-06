{
  imports = [
    # Bootloader configuration
    ./modules/bootloader.nix

    # Audio settings
    ./modules/audio.nix

    # Zram configuration
    ./modules/zram.nix

    # Hardware & Drivers configurations
    ./modules/drivers.nix

    # Power management settings
    ./modules/powermanagement.nix

    # User environment (programs, services, etc.)
    ./modules/nixos.nix
    ./modules/programs.nix
    ./modules/Environment.nix
    ./modules/fonts.nix
    ./modules/user.nix
    ./modules/wine.nix
    ./modules/media.nix

    # window manager settings
    ./modules/hyprland.nix

    # System services and security
    ./modules/security.nix
    ./modules/networking.nix
    ./modules/services.nix
    #./modules/bluetooth.nix
    #./modules/virtualisation.nix
    #./modules/nautilus.nix
    ./modules/locale.nix
    # ./laptop.nix
    ./modules/gnome.nix
    ./modules/appearance.nix
  ];
}
