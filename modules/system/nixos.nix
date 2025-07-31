# ---- docs.nix ---- #
{ settings, lib, pkgs, ... }:
let
  _docs = settings.modules.system.docs;

  # /var/tmp doesn't seem to be on tmpfs like /tmp (when using zram) but
  # seems to contain near duplicate systemd unit folders?...
  # dir must exist on a new system to avoid error as nixos-rebuild uses
  # mktemp -d and won't implicitly create parents
  nixTmpDir = "/var/tmp";

in {

  # For Faster Rebuilding Disable These
  documentation = {
    enable = _docs.enable;
    doc.enable = _docs.doc.enable;
    man = {
      enable = _docs.man.enable;
      generateCaches = _docs.man.generateCaches;
    };
    dev.enable = _docs.dev.enable;
    info.enable = _docs.info.enable;
    nixos.enable = _docs.nixos.enable;
  };

  nix = {
    package = pkgs.nixVersions.latest;
    gc = {
      automatic = false;
      dates = "03:15";
      options = "--delete-older-than 10d";
    };
    settings = {
      sandbox = true;
      keep-outputs = false;
      keep-derivations = false;
      fallback = true; # don't fail if remote builder unavailable
      warn-dirty = true;
      builders-use-substitutes = true;
      download-buffer-size = 536870912; # 512MiB
      min-free = 1073741824; # 1 GiB
      use-xdg-base-directories = true;
      # https://bmcgee.ie/posts/2023/12/til-how-to-optimise-substitutions-in-nix/
      http-connections = 128;
      max-jobs = 1;
      # max-silent-time = 3600; # kills build after 1hr with no logging
      max-substitution-jobs = 128;

      # Optimise new store contents - `nix-store optimise` cleans old
      auto-optimise-store = true;

      trusted-users = [ "@wheel" "root" "${settings.user.username}" ];
      allowed-users = [ "@wheel" "root" "${settings.user.username}" ];

      # Enable flakes
      experimental-features = [
        "nix-command"
        "flakes"
        "no-url-literals"
        "pipe-operators"
        "recursive-nix"
      ];

      trusted-substituters = [ "https://nix-community.cachix.org" ];
      substituters = [
        # high priority since it's almost always used
        "https://cache.nixos.org?priority=10"
        "https://hyprland.cachix.org?priority=10"

        #"https://cache.garnix.io"
        #"https://cuda-maintainers.cachix.org"
        "https://devenv.cachix.org"
        "https://nix-community.cachix.org"
        #"https://nix-gaming.cachix.org"
        "https://nixpkgs-python.cachix.org"
        "https://nixpkgs-wayland.cachix.org"
      ];
      # Enable cachix
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        #"cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
        "nixpkgs-python.cachix.org-1:hxjI7pFxTyuTHn2NkvWCrAUcNZLNS3ZAvfYNuYifcEU="
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
        #"cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      ];
    };

    # ---- extraOptions ---- #
    # extraOptions = ''
    #   sandbox = true
    #   max-jobs = auto
    #   auto-optimise-store = true
    #   experimental-features = nix-command flakes recursive-nix
    # '';
  };

  nixpkgs = {
    hostPlatform = lib.mkDefault "${settings.system.architecture}";
    config = {
      rocmSupport = settings.modules.system.rocm.enable;
      allowUnfree = true;
    };
  };

  system = {
    autoUpgrade.enable = settings.system.upgrade.enable or false;
    autoUpgrade.allowReboot = settings.system.upgrade.allowReboot or false;
    autoUpgrade.channel = settings.system.upgrade.channel;
    # autoUpgrade.flags = [ "--update-input" "nixpkgs" "--commit-lock-file" ];
    stateVersion = settings.system.stateVersion;
  };

  # ------------------------------------------------
  # ---- Enable automatic updates
  # ------------------------------------------------
  systemd.timers.nixos-upgrade = {
    enable = false;
    timerConfig.OnCalendar = "weekly";
    wantedBy = [ "timers.target" ];
  };
  systemd.services.nixos-upgrade = {
    enable = false;
    script = "${pkgs.nixos-rebuild}/bin/nixos-rebuild switch --upgrade";
    serviceConfig.Type = "oneshot";
  };

  # Nicely reload system units when changing configs
  # systemd.user.startServices = "sd-switch";

  # ------------------------------------------------
  # ---- Enable "nh" nix cli helper.
  # ------------------------------------------------
  # alternative for `$ sudo nixos-rebuild switch --flake .#nixos`
  # nh os switch .#nixos
  # Or using an environment variable
  # environment.variables.FLAKE = "/home/${settings.user.username}/nixxin";
  # Than you can just run: nh os switch -H default
  # -H => is for hostname, Like in your terminal => `user@hostname`
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/${settings.user.username}/nixxin";
  };

  programs = {

    # -
    command-not-found.enable = true;

    # -
    fuse.userAllowOther = true;

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # mtr.enable = true;
    # gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    # See https://nix.dev/permalink/stub-ld.
    #? what is nix-ld?
    # Nix-ld is a tool that allows you to run unpatched dynamic binaries on NixOS.
    # It works by creating a profile that contains the necessary libraries and
    # environment variables to run the binary.
    # It is similar to the `nix run` command, but it does not require
    # the binary to be built with Nix.
    nix-ld = {
      enable = true;
      # Include libstdc++ in the nix-ld profile
      libraries = with pkgs; [
        curl
        expat
        fontconfig
        freetype
        fuse3
        icu
        nss
        openssl
        stdenv.cc.cc
        util-linux
        vulkan-headers
        vulkan-loader
        vulkan-tools
        xorg.libX11
        zlib
      ];
    };
  };

  # List services that you want to enable:
  services = {
    # Forces the GPU to always run at full power.
    # This is useful for gaming or other GPU-intensive tasks.
    # If you have a laptop, you may want to disable this.
    # To check if this is working, run:
    # `lspci -k | grep -A 2 VGA`
    # `sudo sh -c 'echo performance > /sys/class/drm/card0/device/power_dpm_state'`
    # `sudo sh -c 'echo performance > /sys/class/drm/card1/device/power_dpm_state'`
    # `sudo sh -c 'echo performance > /sys/class/drm/card*/device/power_dpm_state'`
    # Note: This is not recommended for laptops, as it can cause overheating.
    udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="drm", KERNEL=="card*", ATTR{power_dpm_state}="performance"
    '';

    dbus.enable = true;
    dbus.dbusPackage = pkgs.dbus;
    dbus.packages = [ pkgs.dconf pkgs.gcr ];
    dbus.brokerPackage = pkgs.dbus-broker;
    dbus.implementation = "broker"; # "dbus" or "broker";
    accounts-daemon.enable = true;
    udisks2.enable = true;
    fwupd.enable = true;

    # Tumbler, A D-Bus thumbnailer service.
    tumbler.enable = true;

    # ACPI daemon
    # 🔌 It listens for power-related events from the system firmware (BIOS/UEFI), such as:
    # Power button press 💡
    # Lid close/open (on laptops)
    # Sleep/wake events 💤
    # Battery state changes 🔋
    # AC adapter plugged/unplugged 🔌
    acpid.enable = true;

    # The color management daemon.
    colord.enable = true;

    # An automatic device mounting daemon.
    devmon.enable = true;

    # A DBus service that provides location information for accessing.
    # geoclue2.enable = true;
    # geoclue2.enableWifi = true;

    # Populates contents of /bin and /usr/bin/
    # envfs.enable = false;

    # A userspace virtual filesystem.
    gvfs.enable = true; # A lot of mpris packages require it.

    # Printing support through the CUPS daemon.
    # printing.enable = false; # Enable CUPS to print documents.

    # sysprof profiling daemon.
    # sysprof is a system-wide profiler that collects performance data.
    # It can be used to analyze the performance of applications and the system.
    # It is useful for debugging performance issues and optimizing applications.
    # It can be used to profile applications, system services, and the kernel.
    sysprof.enable = true;

    logind.extraConfig = ''
      # don’t shutdown when power button is short-pressed
      HandlePowerKey=ignore
    '';
  };

  environment.variables = {
    NIX_AUTO_RUN = "1"; # auto-run programs using nix-index-database
    NIXPKGS_ALLOW_UNFREE = "1"; # support for non-free (proprietary) software.
    NIXPKGS_ALLOW_INSECURE = "1";
    # NIXPKGS_ALLOW_BROKEN = "1"; # allow broken packages to be installed.
    # NIXPKGS_ALLOW_UNFREE_OVERLAYS = "1"; # allow unfree overlays to be used.
    # NIXPKGS_ALLOW_BROKEN_OVERLAYS = "1"; # allow broken overlays to be used.
  };

  home-manager.users.${settings.user.username} = {
    programs.home-manager.enable = true;
    home = {
      sessionPath =
        [ "$HOME/.bin" "$HOME/.local/bin" "$HOME/.cargo/bin" "$HOME/.go/bin" ];

      sessionVariables = {
        # Set the default pager to less
        # This is useful for programs that use a pager, such as `man` or `git log`
        # It allows you to scroll through the output using the arrow keys or page up
        # and page down keys.
        # You can also use the space bar to scroll down one page at a time.
        # You can also use the `q` key to quit the pager.
        PAGER = "less";

        LESS = "-R";
        VIRTUAL_ENV_DISABLE_PROMPT = "1";
        PIPENV_SHELL_FANCY = "1";
        ERL_AFLAGS = "-kernel shell_history enabled";
      };
    };
  };

  nixpkgs.overlays = [
    # nixos-rebuild ignores tmpdir set (elsewhere in file) to avoid OOS
    # during build when tmp on tmpfs. workaround is this overlay. see:
    # https://github.com/NixOS/nixpkgs/issues/293114#issuecomment-2381582141
    (_final: prev: {
      nixos-rebuild = prev.nixos-rebuild.overrideAttrs (oldAttrs: {
        nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [ prev.makeWrapper ];
        postInstall = oldAttrs.postInstall + ''
          wrapProgram $out/bin/nixos-rebuild --set TMPDIR ${nixTmpDir}
        '';
      });
    })
  ];

  # prevent OOS error during builds when using zram/tmp on tmpfs
  systemd.services.nix-daemon.environment.TMPDIR = nixTmpDir;
  systemd.tmpfiles.rules = [ "d ${nixTmpDir} 0755 root root 1d" ];
  # OOM config (https://discourse.nixos.org/t/nix-build-ate-my-ram/35752)
  systemd.slices."nix-daemon".sliceConfig = {
    ManagedOOMMemoryPressure = "kill";
    ManagedOOMMemoryPressureLimit = "90%";
  };
  systemd.services."nix-daemon".serviceConfig = {
    Slice = "nix-daemon.slice";
    # If kernel OOM does occur, strongly prefer
    # killing nix-daemon child processes
    OOMScoreAdjust = 1000;
  };

  environment.systemPackages = with pkgs; [
    # Nix Related Packages
    # it provides the command `nom` works just like `nix`
    # with more details log output
    cached-nix-shell # fast nix-shell scripts
    fmt # Small, safe and fast formatting library
    home-manager # A Nix-based user environment configurator
    inxi # Full featured CLI system information tool
    nix-bash-completions # Bash completions for Nix, NixOS, and NixOps
    nix-btm # Rust tool to monitor Nix processes
    nix-direnv # Fast, persistent use_nix implementation for direnv
    nix-doc # Interactive Nix documentation tool
    nix-index # A files database for nixpkgs
    nix-output-monitor # Processes output of Nix commands to show helpful and pretty information
    nix-prefetch # Prefetch any fetcher function call, e.g. package sources
    nix-prefetch-git # Script used to obtain source hashes for fetchgit
    nix-prefetch-github # Prefetch sources from github
    nix-tree # Interactively browse a Nix store paths dependencies
    nixfmt-classic # An opinionated formatter for Nix
    nixos-install-tools # The essential commands from the NixOS installer as a package
    nixos-shell # Spawns lightweight nixos vms in a shell
    nixpkgs-lint # A utility for Nixpkgs contributors to check Nixpkgs for common errors
    nixpkgs-review
    statix # nvim-lint
    deadnix
    cachix

    # Nix language server
    nixd # Feature-rich Nix language server interoperating with C++ nix
    nil # Yet another language server for Nix

    # Nix Formatters:
    # alejandra # Uncompromising Nix Code Formatter [alejandra file.nix]
    nixfmt-rfc-style # Official formatter for Nix code [nixfmt file.nix]
    nixpkgs-fmt # Nix code formatter for nixpkgs [nixpkgs-fmt file.nix]

    nixdoc # Generate documentation for Nix functions
    node2nix # Generate Nix expressions to build NPM packages

    # Yet another nix cli helper
    nh

    (pkgs.writeShellScriptBin "toggle-services" ''
      SERVICES=("$@")

      toggleService() {
          SERVICE="$1"

          if [[ ! "$SERVICE" == *".service"* ]]; then SERVICE="''${SERVICE}.service"; fi

          if systemctl list-unit-files "$SERVICE" &>/dev/null; then
              if systemctl is-active --quiet "$SERVICE"; then
                  echo "Stopping \"$SERVICE\"..."
                  sudo systemctl stop "$SERVICE"
              else
                  echo "Starting \"$SERVICE\"..."
                  sudo systemctl start "$SERVICE"
              fi
          else
              echo "\"$SERVICE\" does not exist"
          fi
      }

      # Retain sudo
      trap "exit" INT TERM; trap "kill 0" EXIT; sudo -v || exit $?; sleep 1; while true; do sleep 60; sudo -nv; done 2>/dev/null &

      for i in "''${SERVICES[@]}"
      do
          toggleService "$i"
      done
    '')
  ];
}
