# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ self, inputs, config, settings, pkgs, ... }: {
  imports = [
    ./hardware.nix
    ./packages.nix
    ./stylix
    ./modules/cli
    ./modules/dev
    ./modules/flags
    ./modules/media
    ./modules/terminal
    ./modules/wm/gnome
    ./modules/wm/hyprland

    ./modules/android.nix
    ./modules/anyrun.nix
    ./modules/applications.nix
    ./modules/audio.nix
    ./modules/boot.nix
    ./modules/cli-collection.nix
    ./modules/codex.nix
    ./modules/data-transferring.nix
    ./modules/dconf.nix
    ./modules/default-apps.nix
    ./modules/environment.nix
    ./modules/gaming.nix
    ./modules/locale.nix
    ./modules/nautilus.nix
    ./modules/networking.nix
    ./modules/power-management.nix
    ./modules/systemd.nix
    ./modules/users.nix
    ./modules/virtualisation.nix
    ./modules/wine.nix
    ./modules/xdg.nix
    ./modules/xremap.nix
    ./modules/zram.nix
  ];
  documentation.dev.enable = true;
  documentation.doc.enable = true;
  documentation.info.enable = true;
  documentation.man.enable = true;
  documentation.nixos.enable = true;
  environment.localBinInPath = true;
  # ~~~~~~~~~~~~~~~~~~~
  # ~~~~~~~ nix ~~~~~~~
  # ~~~~~~~~~~~~~~~~~~~
  nix = {
    package = pkgs.nixVersions.latest;
    gc.automatic = true;
    gc.dates = "03:15";
    gc.options = "--delete-older-than 10d";
    settings = {
      # for nix-direnv
      sandbox = false;
      keep-outputs = true;
      keep-derivations = true;
      builders-use-substitutes = true;
      experimental-features =
        [ "nix-command" "flakes" "no-url-literals" "pipe-operators" ];
      substituters = [
        "https://cache.nixos.org"
        "https://cuda-maintainers.cachix.org"
        "https://hyprland.cachix.org"
        "https://nix-community.cachix.org"
        "https://nix-gaming.cachix.org"
        "https://nixpkgs-python.cachix.org"
        "https://nixpkgs-wayland.cachix.org"
      ];
      # trusted-substituters = [ "https://nix-community.cachix.org" ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
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
  # ~~~~~~~~~~~~~~~~~~~~~~~
  # ~~~~~~~ nixpkgs ~~~~~~~
  # ~~~~~~~~~~~~~~~~~~~~~~~
  nixpkgs = {
    config = {
      rocmSupport = (if settings.gpuType == "amd" then true else false);
      allowUnfree = true;
    };
  };
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # ~~~~~~~ home-manager ~~~~~~~
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  home-manager = {
    # users.${settings.username} = import (./. + "/home.nix");
    extraSpecialArgs = {
      inherit inputs;
      inherit settings;
      inherit self;
    };
    verbose = true;
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "old";
    stylix.targets.hyprland.enable = false;
    programs.home-manager.enable = true;
    programs.bat.enable = true;
    programs.clang-format.enable = true;
    programs.deadnix.enable = true;
    programs.deno.enable = true;
    programs.eza.enable = true;
    programs.hclfmt.enable = true;
    programs.nixfmt.enable = true;
    programs.ruff.check = true;
    programs.ruff.format = true;
    programs.rustfmt.enable = true;
    programs.shellcheck.enable = true;
    programs.shfmt.enable = true;
    programs.ssh.enable = true;
    programs.stylua.enable = true;
    programs.yamlfmt.enable = true;
    home = {
      username = settings.username;
      homeDirectory = "/home/${settings.username}";
      stateVersion = settings.homeStateVersion;
      sessionVariables = {
        EDITOR = settings.editor;
        TERM = settings.term;
        BROWSER = settings.browser;
        NIXPKGS_ALLOW_UNFREE = "1";
        NIXPKGS_ALLOW_INSECURE = "1";

        PATH = "$HOME/.npm-packages/bin:$HOME/.bun/bin:$PATH";
        NODE_PATH = "$HOME/.npm-packages/lib/node_modules:$NODE_PATH";

        # Fixes `bad interpreter: Text file busy`
        # https://github.com/NixOS/nixpkgs/issues/314713
        UV_USE_IO_URING = "0";

        # clean up ~
        LESSHISTFILE = "${config.xdg.cacheHome}/less/history";
        LESSKEY = "${config.xdg.configHome}/less/lesskey";

        WINEPREFIX = "${config.xdg.dataHome}/wine";
        XAUTHORITY = "$XDG_RUNTIME_DIR/Xauthority";

        DIRENV_LOG_FORMAT = "";

        # auto-run programs using nix-index-database
        NIX_AUTO_RUN = "1";
      };
      sessionPath = [ "$HOME/.local/bin" ];
    };
    manual = {
      # disable manuals as nmd fails to build often
      html.enable = false;
      json.enable = false;
      manpages.enable = false;
    };
    programs.mypy.directories = {
      "tasks" = {
        directory = ".";
        modules = [ ];
        files = [ "**/tasks.py" ];
        extraPythonPackages =
          [ pkgs.python3.pkgs.deploykit pkgs.python3.pkgs.invoke ];
      };
      "machines/eva/modules/prometheus" = { };
      "openwrt" = { };
      "home-manager/modules/neovim" = {
        options = [ "--ignore-missing-imports" ];
      };
    };
    # QT Settings
    qt = {
      enable = true;
      platformTheme.name = settings.qtPlatformTheme;
      style.name = settings.qtStyle;
    };
    # gtk = {
    #   enable = true;
    #   cursorTheme = {
    #     name = settings.cursorTheme;
    #     size = settings.cursorSize;
    #     package = settings.cursorPackage;
    #   };
    #   font = {
    #     name = settings.fontName;
    #     package = settings.fontPackage;
    #     size = settings.fontSize;
    #   };
    #   iconTheme = {
    #     name = settings.iconName;
    #     package = settings.iconPackage;
    #   };
    #   theme = {
    #     name = lib.mkForce settings.gtkTheme;
    #     package = lib.mkForce settings.gtkPackage;
    #   };
    #   gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
    # };
  };
  # ~~~~~~~~~~~~~~~~~~~~~~~~
  # ~~~~~~~ Services ~~~~~~~
  # ~~~~~~~~~~~~~~~~~~~~~~~~
  services = {
    tumbler.enable = true;
    acpid.enable = true;

    seatd.enable = true;
    # seatd.user = "root";
    # services.seatd.group = "seat";

    # disable NetworkManager-wait-online.service

    # xserver.excludePackages = with pkgs; [ xterm ];
    xserver = {
      enable = true;
      displayManager.startx.enable = true;
      displayManager.gdm.enable = true; # x11
      displayManager.gdm.wayland = true; # wayland
      desktopManager.gnome = {
        enable = true;
        extraGSettingsOverridePackages = [ pkgs.nautilus-open-any-terminal ];
      };
    };
    # Enable the GNOME Desktop Environment.
    displayManager.enable = true;
    displayManager.defaultSession = settings.defaultSession;

    # populates contents of /bin and /usr/bin/
    envfs.enable = true;
    accounts-daemon.enable = true;
    dbus = {
      enable = true;
      packages = [ pkgs.dconf ];
      implementation = "broker";
    };
    flatpak.enable = false;

    # Enable touchpad support (enabled default in most desktopManager).
    libinput.mouse.accelSpeed = "-0.5";

    # a DBus service that provides power management support to applications.
    openssh.enable = true; # Enable the OpenSSH daemon.
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
  # ~~~~~~~~~~~~~~~~~~~~~~~~
  # ~~~~~~~ Programs ~~~~~~~
  # ~~~~~~~~~~~~~~~~~~~~~~~~
  programs = {
    nh.enable = true;
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
    fuse.userAllowOther = true;

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
    sudo.enable = true;
    # don't ask for password for wheel group
    sudo.wheelNeedsPassword = false;
    # show Password as stars in Terminals.
    sudo.extraConfig = "Defaults        env_reset,pwfeedback";
    allowSimultaneousMultithreading = true; # to allow SMT/hyperthreading
    polkit.enable = true;
    isolate.enable = false;
    #sudo.configFile = ''
    #  root   ALL=(ALL:ALL) SETENV: ALL
    #  %wheel ALL=(ALL:ALL) SETENV: ALL
    #  celes  ALL=(ALL:ALL) SETENV: ALL
    #'';
  };
  # ~~~~~~~~~~~~~~~~~~~~~~
  # ~~~~~~~ System ~~~~~~~
  # ~~~~~~~~~~~~~~~~~~~~~~
  system = {
    # autoUpgrade.enable = true;
    # autoUpgrade.allowReboot = true;
    # autoUpgrade.channel = "https://channels.nixos.org/nixos-24.05";
    stateVersion = settings.systemStateVersion;
  };
}
