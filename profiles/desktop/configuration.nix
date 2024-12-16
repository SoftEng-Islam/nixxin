# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ pkgs, lib, settings, ... }: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../themes/stylix.nix
    ../../system/bundle-desktop.nix
    (./. + "../../../system/wm" + ("/" + builtins.elemAt settings.wm 0)
      + ".nix")
    (./. + "../../../system/wm" + ("/" + builtins.elemAt settings.wm 1)
      + ".nix")
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  nixpkgs.overlays =
    import ../../lib/overlays.nix; # Add packages from the pkgs dir
  nixpkgs.config.allowUnfree = true;
  # Networking
  networking.hostName = settings.hostname;
  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "dnsmasq";
  networking.extraHosts = ''
    127.0.0.1 softeng.home
  '';
  # Timezone
  time.timeZone = settings.timezone;
  services.chrony.enable = true;

  # Locale.
  i18n.defaultLocale = settings.locale;
  i18n.extraLocaleSettings = { LC_ALL = settings.locale; };

  # Users.
  users.users.${settings.username} = {
    isNormalUser = true;
    description = settings.username;
    extraGroups = [ "wheel" "gamemode" ];
  };
  # Use zsh. TODO: option to flake.nix, several shells.
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  # See https://nix.dev/permalink/stub-ld.
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [ stdenv.cc.cc ];

  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [{
      from = 1714;
      to = 1764;
    } # KDE Connect
      ];
    allowedUDPPortRanges = [{
      from = 1714;
      to = 1764;
    } # KDE Connect
      ];
    # allowedUDPPorts = lib.mkIf settings.enableVPN [51820];
    allowedUDPPorts = [ 5900 5901 51820 ];
    allowedTCPPorts = [ 5900 5901 ];
  };

  # Security
  security.allowSimultaneousMultithreading = true; # to allow SMT/hyperthreading
  security.sudo.extraConfig =
    "Defaults        env_reset,pwfeedback"; # show Password as stars in Terminals.
  #security.selinux = null;
  security.polkit.enable = true;
  #security.polkit.debug = true;

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

  # A lot of mpris packages require it.
  services.gvfs.enable = true;
  services.upower.enable = true;

  services.xserver.videoDrivers = [ "displaylink" "modesetting" ];
  services.printing.enable = true;

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
