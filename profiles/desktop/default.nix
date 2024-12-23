# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ mySettings, pkgs, lib, config, ... }: {
  imports = [
    # (./. + "../" + ("/" + builtins.elemAt mySettings.wm 1) + ".nix")
    ./hardware-configuration.nix
    ./themes/stylix.nix
    ./modules/wm/gnome
    ./modules/wm/hyprland

    # ./modules/system/android.nix
    ./modules/system/audio.nix
    # ./modules/system/beesd.nix
    ./modules/system/boot.nix
    ./modules/system/cli-collection.nix
    ./modules/system/data-transferring.nix
    ./modules/system/desktop-apps.nix
    ./modules/system/drivers.nix
    ./modules/system/environment.nix
    ./modules/system/fonts.nix
    ./modules/system/gaming.nix
    ./modules/system/locale.nix
    ./modules/system/media.nix
    # ./modules/system/mouse.nix
    ./modules/system/nautilus.nix
    ./modules/system/networking.nix
    ./modules/system/packages.nix
    ./modules/system/power-management.nix
    # ./modules/system/printing.nix
    ./modules/system/shell.nix
    ./modules/system/systemd.nix
    ./modules/system/users.nix
    ./modules/system/wine.nix
    ./modules/system/xdg.nix
    ./modules/system/zram.nix

    ./modules/programs/cli
    ./modules/programs/dev

  ];

  # documentation.nixos.enable = false; # .desktop
  # documentation.nixos.enable = lib.mkForce false;
  # documentation.info.enable = false;
  # documentation.doc.enable = false;

  nix = {
    package = with pkgs; [ nixVersions.latest nixFlakes ];
    gc.automatic = true;
    gc.dates = "03:15";
    gc.options = "--delete-older-than 10d";
    settings = {
      # for nix-direnv
      sandbox = false;
      keep-outputs = true;
      keep-derivations = true;
      experimental-features = [ "nix-command" "flakes" "pipe-operators" ];
      substituters = [
        "https://cache.nixos.org"
        "https://hyprland.cachix.org"
        "https://nix-community.cachix.org"
        "https://cuda-maintainers.cachix.org"
        "https://nixpkgs-wayland.cachix.org"
        "https://nixpkgs-python.cachix.org"
      ];
      trusted-substituters = [ "https://nix-community.cachix.org" ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nixpkgs-python.cachix.org-1:hxjI7pFxTyuTHn2NkvWCrAUcNZLNS3ZAvfYNuYifcEU="
      ];
      trusted-users = [ "@wheel" "root" ];
      fallback = true;
      warn-dirty = false;
      auto-optimise-store = true;
    };

    extraOptions = ''
      sandbox = false
      max-jobs = 4
      auto-optimise-store = true
      experimental-features = nix-command flakes
    '';
  };
  nixpkgs = {
    config = {
      rocmSupport = false;
      allowUnfree = true;
    };
  };

  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # Use zsh.
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # Services
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  services = {
    # Enable the X11 windowing system.
    xserver.enable = false;
    xserver.displayManager.gdm.wayland = true;
    xserver.videoDrivers = [ "amdgpu" ]; # "displaylink" "modesetting"
    xserver.xkb = {
      variant = "";
      layout = "us,ara";
      options = "grp:win_space_toggle";
    };

    # Enable the GNOME Desktop Environment.
    xserver.displayManager.gdm.enable = true;
    xserver.desktopManager.gnome.enable = true;

    displayManager.enable = true;
    displayManager.defaultSession = mySettings.defaultSession;
    # displayManager.defaultSession = "gnome"; # Set `gnome` or `hyprland`

    # populates contents of /bin and /usr/bin/
    envfs.enable = true;
    accounts-daemon.enable = true;
    dbus.implementation = "broker";
    flatpak.enable = false;

    # Enable touchpad support (enabled default in most desktopManager).
    libinput.mouse.accelSpeed = "-0.5";

    # a DBus service that provides power management support to applications.
    openssh.enable = true; # Enable the OpenSSH daemon.
    upower.enable = true;
    power-profiles-daemon.enable = true;
    printing.enable = false; # Enable CUPS to print documents.
    sysprof.enable = false; # Whether to enable sysprof profiling daemon.

    # a DBus service that allows applications to update firmware.
    fwupd.enable = false;
    geoclue2.enable = true;
    colord.enable = true;

    # automount
    devmon.enable = true;
    udisks2.enable = true;
    gvfs.enable = true; # A lot of mpris packages require it.

    # logind
    logind.extraConfig = ''
      HandlePowerKey=ignore
      HandleLidSwitch=suspend
      HandleLidSwitchExternalPower=ignore
    '';
  };

  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # Programs
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  programs = {

    # See https://nix.dev/permalink/stub-ld.
    # run unpatched dynamic binaries on NixOS
    nix-ld = {
      enable = true;
      libraries = with pkgs; [ fontconfig freetype stdenv.cc.cc util-linux ];
    };

    command-not-found.enable = false;

    # corectrl to overclock your CPU APU GPU
    corectrl.enable = true;
    corectrl.gpuOverclock.enable = true;
    corectrl.gpuOverclock.ppfeaturemask = "0xffffffff";

    dconf.enable = true; # dconf
    droidcam.enable = true; # camera
    mtr.enable = true;
    xwayland.enable = false; # to run x11 on Wayland

    htop.enable = true;
    htop.settings = { tree_view = 1; };

    gnupg.agent.enable = true;
    gnupg.agent.enableSSHSupport = true;

    # Required by gnome file managers
    file-roller.enable = true;
    gnome-disks.enable = true;

    # required by libreoffice
    # java.enable = true;
  };

  # ~~~~~~~~~~~~~~~~~~~~~~~~
  # ~~~~~~~ Security ~~~~~~~
  # ~~~~~~~~~~~~~~~~~~~~~~~~
  security = {
    # show Password as stars in Terminals.
    sudo.extraConfig = "Defaults        env_reset,pwfeedback";
    allowSimultaneousMultithreading = true; # to allow SMT/hyperthreading
    polkit.enable = true;
    pam.services.astal-auth = { };
    isolate.enable = false;
  };

  system = {
    # autoUpgrade.enable = true;
    # autoUpgrade.allowReboot = true;
    # autoUpgrade.channel = "https://channels.nixos.org/nixos-24.05";
  };

  home-manager = {
    stylix.targets.hyprland.enable = false;

    programs = {
      # sagemath.enable = true;
      # Let Home Manager install and manage itself.
      home-manager.enable = true;
    };
    services = {
      kdeconnect.enable = false;
      ssh-agent.enable = true;
    };
    users = {
      users.${mySettings.username} = { ... }: {
        isNormalUser = true;
        programs.bash.enable = true;
        gtk = {
          enable = true;
          cursorTheme = {
            name = mySettings.cursorTheme;
            size = mySettings.cursorSize;
            package = mySettings.cursorPackage;
          };
          font = {
            name = mySettings.fontName;
            package = mySettings.fontPackage;
            size = mySettings.fontSize;
          };
          iconTheme = {
            name = mySettings.iconName;
            package = mySettings.iconPackage;
          };
          theme = {
            name = lib.mkForce mySettings.gtkTheme;
            package = lib.mkForce mySettings.gtkPackage;
          };
          gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
        };
      };
    };
    home = {
      username = mySettings.username;
      homeDirectory = "/home/${mySettings.username}";
      # Home Manager can also manage your environment variables through
      # 'home.sessionVariables'. These will be explicitly sourced when using a
      # shell provided by Home Manager. If you don't want to manage your shell
      # through Home Manager then you have to manually source 'hm-session-vars.sh'
      # located at either
      #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
      #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
      #  /etc/profiles/per-user/softeng/etc/profile.d/hm-session-vars.sh
      sessionVariables = {
        EDITOR = mySettings.editor;
        TERM = mySettings.term;
        BROWSER = mySettings.browser;
      };
      # Home Manager is pretty good at managing dotfiles. The primary way to manage
      # plain files is through 'home.file'.
      file = {
        # # Building this configuration will create a copy of 'dotfiles/screenrc' in
        # # the Nix store. Activating the configuration will then make '~/.screenrc' a
        # # symlink to the Nix store copy.
        # ".screenrc".source = dotfiles/screenrc;

        # # You can also set the file content immediately.
        # ".gradle/gradle.properties".text = ''
        #   org.gradle.console=verbose
        #   org.gradle.daemon.idletimeout=3600000
        # '';
      };
    };

    xdg = {
      enable = true;
      configFile."gtk-4.0/gtk.css".enable = lib.mkForce false;
      userDirs = {
        enable = true;
        createDirectories = true;
        music = "${config.home.homeDirectory}/Music";
        videos = "${config.home.homeDirectory}/Videos";
        pictures = "${config.home.homeDirectory}/Pictures";
        download = "${config.home.homeDirectory}/Downloads";
        documents = "${config.home.homeDirectory}/Documents";
        templates = null;
        desktop = null;
        publicShare = null;
        extraConfig = {
          XDG_DOTFILES_DIR = "${mySettings.dotfilesDir}";
          XDG_BOOK_DIR = "${config.home.homeDirectory}/Books";
        };
      };
    };

    # disable manuals as nmd fails to build often
    manual = {
      html.enable = false;
      json.enable = false;
      manpages.enable = false;
    };

    # QT Settings
    qt = {
      enable = true;
      platformTheme.name = mySettings.qtPlatformTheme;
      style.name = mySettings.qtStyle;
    };
  };

  environment.systemPackages = with pkgs; [
    wayland
    wl-clipboard
    wayvnc

    # Themes & Graphical Interfaces
    gtk3 # A multi-platform toolkit for creating graphical user interfaces
    gtk4 # A multi-platform toolkit for creating graphical user interfaces
    gtk_engines # Theme engines for GTK 2
    libadwaita # Library to help with developing UI for mobile devices using GTK/GNOME

    adw-gtk3 # Theme from libadwaita ported to GTK-3
    gruvbox-dark-gtk # Gruvbox theme for GTK based desktop environments
    gruvbox-gtk-theme # GTK theme based on the Gruvbox colour palette

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

    cached-nix-shell # fast nix-shell scripts
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
  # Don't Change The Fucking Version!
  system.stateVersion =
    mySettings.systemStateVersion; # Did you read the comment?

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # Don't Change The Fucking Version!
  home-manager.users.${mySettings.username}.home.stateVersion =
    mySettings.homeStateVersion;
}
