# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ settings, pkgs, ... }: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    (./. + "../../system/desktop" + ("/" + builtins.elemAt settings.wm 0)
      + ".nix")
    (./. + "../../system/desktop" + ("/" + builtins.elemAt settings.wm 1)
      + ".nix")
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
    ../../system/desktop/locale.nix
    ../../system/desktop/media.nix
    ../../system/desktop/nautilus.nix
    ../../system/desktop/networking.nix
    ../../system/desktop/nixos.nix
    ../../system/desktop/packages.nix
    ../../system/desktop/power-management.nix
    ../../system/desktop/shell.nix
    ../../system/desktop/users.nix
    ../../system/desktop/wayland.nix
    ../../system/desktop/wine.nix
    ../../system/desktop/xdg.nix
    ../../system/desktop/zram.nix
  ];

  # Use zsh.
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  services.accounts-daemon.enable = true;
  services.dbus.implementation = "broker";
  services.flatpak.enable = false;
  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.mouse.accelSpeed = "-0.5";
  # a DBus service that provides power management support to applications.
  services.openssh.enable = true; # Enable the OpenSSH daemon.
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;
  services.printing.enable = false; # Enable CUPS to print documents.
  services.sysprof.enable = false; # Whether to enable sysprof profiling daemon.
  # a DBus service that allows applications to update firmware.
  services.fwupd.enable = false;
  services.geoclue2.enable = true;
  services.colord.enable = true;
  # automount
  services.devmon.enable = true;
  services.udisks2.enable = true;
  services.gvfs.enable = true; # A lot of mpris packages require it.
  # logind
  services.logind.extraConfig = ''
    HandlePowerKey=ignore
    HandleLidSwitch=suspend
    HandleLidSwitchExternalPower=ignore
  '';
  services.displayManager.enable = true;
  services.displayManager.defaultSession = "gnome"; # Set `gnome` or `hyprland`

  programs.corectrl.enable = true;
  programs.corectrl.gpuOverclock.enable = true;
  programs.corectrl.gpuOverclock.ppfeaturemask = "0xffffffff";
  programs.dconf.enable = true; # dconf
  programs.droidcam.enable = true; # camera
  programs.mtr.enable = true;
  programs.xwayland.enable = false;
  programs.htop.enable = true;
  programs.htop.settings = { tree_view = 1; };
  programs.gnupg.agent.enable = true;
  programs.gnupg.agent.enableSSHSupport = true;

  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # Security
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # show Password as stars in Terminals.
  security.sudo.extraConfig = "Defaults        env_reset,pwfeedback";
  security.allowSimultaneousMultithreading = true; # to allow SMT/hyperthreading
  security.polkit.enable = true;
  security.pam.services.astal-auth = { };

  # system.autoUpgrade.enable = true;
  # system.autoUpgrade.allowReboot = true;
  # system.autoUpgrade.channel = "https://channels.nixos.org/nixos-24.05";
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
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
