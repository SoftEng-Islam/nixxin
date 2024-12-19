# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ pkgs, ... }: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ("../../system/desktop" + ("/" + builtins.elemAt settings.wm 0) + ".nix")
    ("../../system/desktop" + ("/" + builtins.elemAt settings.wm 1) + ".nix")
    ../../themes/stylix.nix
    ../../system/desktop/appearance.nix
    ../../system/desktop/audio.nix
    ../../system/desktop/boot.nix
    ../../system/desktop/cli-collection.nix
    ../../system/desktop/data-transferring.nix
    ../../system/desktop/desktop-apps.nix
    ../../system/desktop/drivers.nix
    ../../system/desktop/environment.nix
    ../../system/desktop/fonts.nix
    ../../system/desktop/gaming.nix
    ../../system/desktop/git.nix
    ../../system/desktop/gnome.nix
    ../../system/desktop/hyprland.nix
    ../../system/desktop/locale.nix
    ../../system/desktop/media.nix
    ../../system/desktop/nautilus.nix
    ../../system/desktop/networking.nix
    ../../system/desktop/nixos.nix
    ../../system/desktop/packages.nix
    ../../system/desktop/power-management.nix
    ../../system/desktop/programs.nix
    ../../system/desktop/security.nix
    ../../system/desktop/services.nix
    ../../system/desktop/shell.nix
    ../../system/desktop/users.nix
    ../../system/desktop/wayland.nix
    ../../system/desktop/wine.nix
    ../../system/desktop/xdg.nix
    ../../system/desktop/zram.nix
  ];

  # Use zsh. TODO: option to flake.nix, several shells.
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;
  # List of globally installed packages.
  environment.systemPackages = with pkgs; [
    home-manager
    nix-index
    pciutils
    go-mtpfs
    ntfs3g
    inetutils
    lsof
    wget
    git
    vim
  ];

  # qt.platformTheme = "qt5ct";
  # qt.style = "adwaita-dark";

  # system.autoUpgrade.enable = true;
  # system.autoUpgrade.allowReboot = true;
  # system.autoUpgrade.channel = "https://channels.nixos.org/nixos-24.05";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
