# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ settings, pkgs, ... }: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    (./. + "../../../system/desktop" + ("/" + builtins.elemAt settings.wm 0)
      + ".nix")
    (./. + "../../../system/desktop" + ("/" + builtins.elemAt settings.wm 1)
      + ".nix")
    ../../themes/stylix.nix
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
    ../../system/desktop/packages.nix
    ../../system/desktop/power-management.nix
    ../../system/desktop/shell.nix
    ../../system/desktop/users.nix
    ../../system/desktop/wayland.nix
    ../../system/desktop/wine.nix
    ../../system/desktop/xdg.nix
    ../../system/desktop/zram.nix
  ];

  # documentation.nixos.enable = false; # .desktop
  # documentation.nixos.enable = lib.mkForce false;
  # documentation.info.enable = false;
  # documentation.doc.enable = false;
  nix = {
    # package = pkgs.nixStable;
    package = pkgs.nixVersions.latest;
    gc.automatic = true;
    gc.dates = "03:15";
    gc.options = "--delete-older-than 10d";
    settings = {
      # for nix-direnv
      keep-outputs = true;
      keep-derivations = true;
      experimental-features = [ "nix-command" "flakes" "pipe-operators" ];
      sandbox = false;
      # substituters = [
      #   "https://cache.nixos.org"
      #   "https://hyprland.cachix.org"
      #   "https://nix-community.cachix.org"
      # ];
      # trusted-substituters = [ "https://nix-community.cachix.org" ];
      # trusted-public-keys = [
      #   "nix-community.cachix.org-1:X+Y5RQ2IjGhGib8V1B9aiATLsRHN/2N9UEf5hGBF3rM=;"
      #   "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      # ];
      trusted-users = [ "@wheel" "root" ];
      fallback = true;
      warn-dirty = false;
      auto-optimise-store = true;
    };

    extraOptions = ''
      sandbox = false
      max-jobs = 4
      auto-optimise-store = true
    '';
  };
  nixpkgs = {
    config = {
      rocmSupport = false;
      allowUnfree = true;
    };
  };
  systemd.timers.nix-cleanup-gcroots = {
    timerConfig = {
      OnCalendar = [ "weekly" ];
      Persistent = true;
    };
    wantedBy = [ "timers.target" ];
  };
  systemd.services.nix-cleanup-gcroots = {
    serviceConfig = {
      Type = "oneshot";
      ExecStart = [
        # delete automatic gcroots older than 30 days
        "${pkgs.findutils}/bin/find /nix/var/nix/gcroots/auto /nix/var/nix/gcroots/per-user -type l -mtime +30 -delete"
        # created by nix-collect-garbage, might be stale
        "${pkgs.findutils}/bin/find /nix/var/nix/temproots -type f -mtime +10 -delete"
        # delete broken symlinks
        "${pkgs.findutils}/bin/find /nix/var/nix/gcroots -xtype l -delete"
      ];
    };
  };
  programs.command-not-found.enable = false;
  security.isolate.enable = false;

  # Use zsh.
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # Services
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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

  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # Programs
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # See https://nix.dev/permalink/stub-ld.
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [ stdenv.cc.cc ];
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
    # Themes & Graphical Interfaces
    gtk3 # A multi-platform toolkit for creating graphical user interfaces
    gtk4 # A multi-platform toolkit for creating graphical user interfaces
    gtk_engines # Theme engines for GTK 2
    libadwaita # Library to help with developing UI for mobile devices using GTK/GNOME

    adw-gtk3 # Theme from libadwaita ported to GTK-3
    gruvbox-dark-gtk # Gruvbox theme for GTK based desktop environments
    gruvbox-gtk-theme # GTK theme based on the Gruvbox colour palette
    colloid-gtk-theme # Modern and clean Gtk theme

    qt6Packages.qtstyleplugin-kvantum
    qt6Packages.qt6ct
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct

    # Icons
    gruvbox-dark-icons-gtk
    gruvbox-plus-icons
    papirus-icon-theme # Pixel perfect icon theme for Linux

    # QT Themes
    adwaita-qt
    adwaita-qt6

    # Plymouth Theme For Nixos:
    plymouth # Boot splash and boot logger
    nixos-bgrt-plymouth # BGRT theme with a spinning NixOS logo

    direnv # Shell extension that manages your environment
    fmt # Small, safe and fast formatting library
    home-manager # A Nix-based user environment configurator
    inxi # Full featured CLI system information tool
    nix-bash-completions # Bash completions for Nix, NixOS, and NixOps
    nix-direnv # Fast, persistent use_nix implementation for direnv
    nix-btm # Rust tool to monitor Nix processes
    nix-doc # Interactive Nix documentation tool
    nix-index # A files database for nixpkgs
    nix-prefetch # Prefetch any fetcher function call, e.g. package sources
    nix-prefetch-github
    nixfmt-classic # An opinionated formatter for Nix
    nixos-shell # Spawns lightweight nixos vms in a shell
    nixpkgs-lint # A utility for Nixpkgs contributors to check Nixpkgs for common errors
    nixpkgs-review
    # Nix language server
    nixd # Feature-rich Nix language server interoperating with C++ nix
    nil # Yet another language server for Nix
    # Nix Formatters:
    nixpkgs-fmt # Nix code formatter for nixpkgs [nixpkgs-fmt file.nix]
    nixfmt-rfc-style # Official formatter for Nix code [nixfmt file.nix]
    alejandra # Uncompromising Nix Code Formatter [alejandra file.nix]
    nixdoc # Generate documentation for Nix functions

    # -----------------------------------------------
    # -----------------------------------------------

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
