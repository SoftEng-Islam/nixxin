# ---- docs.nix ---- #
{
  self,
  settings,
  lib,
  pkgs,
  ...
}:
let
  _docs = settings.modules.system.docs;
  HOME = settings.HOME;
in
{

  # For Faster Rebuilding Disable These
  documentation = {
    enable = _docs.enable;
    doc.enable = _docs.doc.enable;
    man.enable = _docs.man.enable;
    man.generateCaches = _docs.man.generateCaches;
    dev.enable = _docs.dev.enable;
    info.enable = _docs.info.enable;
    nixos.enable = _docs.nixos.enable;
  };

  nix.package = pkgs.nixVersions.latest;
  nix.gc.automatic = false;
  nix.gc.dates = "03:15";
  nix.gc.options = "--delete-older-than 10d";
  nix = {
    settings = {
      # Tell nix to use the xdg spec for base directories
      # while transitioning, any state must be carried over
      # manually, as Nix won't do it for us.
      use-xdg-base-directories = true;

      # Automatically optimise symlinks
      auto-optimise-store = true;

      # Allow sudo users to mark the following values as trusted
      allowed-users = [
        "root"
        "@wheel"
        "nix-builder"
      ];

      # Only allow sudo users to manage the nix store
      trusted-users = [
        "root"
        "@wheel"
        "nix-builder"
      ];

      # Let the system decide the number of max jobs
      # based on available system specs. Usually this is
      # the same as the number of cores your CPU has.
      max-jobs = "auto";

      # Always build inside sandboxed environments
      sandbox = true;
      sandbox-fallback = false;

      # Supported system features
      system-features = [
        "benchmark" # May apply to packages or tests that depend on benchmarking features.
        # "big-parallel" # Enables tasks designed for builds that heavily leverage parallelism (> 16 cores), but enabling it on a system with a low core count (e.g., 4 logical cores) can lead to inefficiencies and potential issues:
        "cgroups" # Specifies that the system supports Linux cgroups (Control Groups), which are often used for resource isolation.
        "kvm" # Indicates that the system can perform builds inside a KVM virtual machine.
        "nixos" # Indicates that the system is running NixOS. This is automatically set on NixOS.
        # "nixos-test" # It allows for automated tests of NixOS modules, configurations, and services in virtual machines or containers. Tests typically run within QEMU virtual machines (or other supported backends) that emulate a full NixOS system.
        "reproducible-paths" # Ensures paths in builds are highly deterministic.
        "sandbox" # Indicates that builds should be sandboxed. A sandboxed build means that the environment is completely isolated and cannot access the host filesystem or network, ensuring purity in builds.
      ];

      # Continue building derivations even if one fails
      # keep-going = false;

      # Fallback to local builds after remote builders are unavailable.
      # Setting this too low on a slow network may cause remote builders
      # to be discarded before a connection can be established.
      connect-timeout = 30; # seconds

      # If we haven't received data for >= 30s, retry the download
      stalled-download-timeout = 30;

      # Show more logs when a build fails and decides to display
      # a bunch of lines. `nix log` would normally provide more
      # information, but this may save us some time and keystrokes.
      log-lines = 30;

      # for direnv GC roots
      keep-outputs = false;
      keep-derivations = false;

      # Don't warn me that my git tree is dirty, I know.
      warn-dirty = false;

      download-buffer-size = 536870912; # 512MiB

      # Use binary cache, this is not Gentoo
      # external builders can also pick up those substituters
      builders-use-substitutes = true;

      # The special value 0 means that the builder should use all available CPU cores in the system.
      cores = 0;

      # Maximum number of parallel TCP connections
      # used to fetch imports and binary caches.
      # 0 means no limit, default is 25.
      http-connections = 35; # lower values fare better on slow connections

      extra-sandbox-paths = [
        "/dev/kfd"
        "/sys/devices/virtual/kfd"
        "/dev/dri"
        "/dev/dri/renderD128"
        "/run/opengl-driver"
        "/run/binfmt"
      ];

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
        "https://cache.nixos.org" # funny binary cache
        "https://cache.privatevoid.net" # for nix-super
        "https://nix-community.cachix.org" # nix-community cache
        "https://hyprland.cachix.org" # hyprland
        "https://nixpkgs-unfree.cachix.org" # unfree-package cache
        "https://devenv.cachix.org" # devenv cache
        "https://nixpkgs-python.cachix.org" # nixpkgs-python
        "https://nixpkgs-wayland.cachix.org" # nixpkgs-wayland
        #"https://nix-gaming.cachix.org" # nix-gaming cache, currently disabled due to instability and lack of maintenance
      ];

      # Enable cachix
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
        "nixpkgs-python.cachix.org-1:hxjI7pFxTyuTHn2NkvWCrAUcNZLNS3ZAvfYNuYifcEU="
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      ];
    };

  };

  nixpkgs = {
    hostPlatform = lib.mkDefault "${settings.system.architecture}";
    config = {
      rocmSupport = settings.modules.system.rocm.enable;

      # Allow broken packages to be built. Setting this to false means packages
      # will refuse to evaluate sometimes, but only if they have been marked as
      # broken for a specific reason. At that point we can either try to solve
      # the breakage, or get rid of the package entirely.
      allowBroken = false;
      allowUnsupportedSystem = true;

      # Really a pain in the ass to deal with when disabled. True means
      # we are able to build unfree packages without explicitly allowing
      # each unfree package.
      allowUnfree = true;

      # Default to none, add more as necessary. This is usually where
      # electron packages go when they reach EOL.
      permittedInsecurePackages = [ ];

      # Nixpkgs sets internal package aliases to ease migration from other
      # distributions easier, or for convenience's sake. Even though the manual
      # and the description for this option recommends this to be true, I prefer
      # explicit naming conventions, i.e., no aliases.
      # allowAliases = false;

      # Enable parallel building by default. This, in theory, should speed up building
      # derivations, especially rust ones. However setting this to true causes a mass rebuild
      # of the *entire* system closure, so it must be handled with proper care.
      enableParallelBuildingByDefault = false;

      # List of derivation warnings to display while rebuilding.
      #  See: <https://github.com/NixOS/nixpkgs/blob/master/pkgs/stdenv/generic/check-meta.nix>
      # NOTE: "maintainerless" can be added to emit warnings
      # about packages without maintainers but it seems to me
      # like there are more packages without maintainers than
      # with maintainers, so it's disabled for the time being.
      showDerivationWarnings = [ ];
    };
  };

  # Upgrade System
  system = {
    # Automatic/Unattended upgrades in general are one of the dumbest things you can set up
    # on virtually any Linux distribution. While NixOS would logically mitigate some of its
    # side effects, you are still risking a system that breaks without you knowing. If the
    # bootloader also breaks during the upgrade, you may not be able to roll back at all.
    # tl;dr: upgrade manually, review changelogs.
    autoUpgrade.enable = settings.system.upgrade.enable or false;
    autoUpgrade.upgrade = settings.system.upgrade.enable or false;
    autoUpgrade.dates = "daily";
    autoUpgrade.allowReboot = settings.system.upgrade.allowReboot or false;
    autoUpgrade.channel = settings.system.upgrade.channel;
    autoUpgrade.operation = "switch";
    autoUpgrade.flags = [
      "--update-input"
      "nixpkgs"
      "--commit-lock-file"
    ];
    stateVersion = settings.system.stateVersion;

    # Globally declare the configurationRevision from shortRev if the git tree is clean,
    # or from dirtyShortRev if it is dirty. This is useful for tracking the current
    # configuration revision in the system profile.
    # configurationRevision = self.shortRev or self.dirtyShortRev;
  };

  # Preserve the flake that built the active system revision in /etc
  # for easier rollbacks with nixos-enter in case we contain changes
  # that are not yet staged.
  # environment.etc."nixxin".source = self;

  # ------------------------------------------------
  # ---- Enable automatic updates
  # ------------------------------------------------
  systemd.timers.nixos-upgrade = {
    enable = true;
    timerConfig.OnCalendar = "weekly";
    wantedBy = [ "timers.target" ];
  };
  systemd.services.nixos-upgrade = {
    enable = true;
    script = "${pkgs.nixos-rebuild}/bin/nixos-rebuild switch --upgrade";
    serviceConfig.Type = "oneshot";
  };

  # Nicely reload system units when changing configs
  # systemd.user.startServices = "sd-switch";

  # ------------------------------------------------
  # ---- Enable "nh" nix cli helper.
  # ------------------------------------------------
  # Alternative for `$ sudo nixos-rebuild switch --flake .#nixos`
  # nh os switch .#nixos
  # Or using an environment variable
  # environment.variables.FLAKE = "/home/${settings.user.username}/nixxin";
  # Than you can just run: nh os switch -H default
  # -H => is for hostname, Like in your terminal => `user@hostname`
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "${HOME}/nixxin";
  };

  programs.command-not-found.enable = false;
  programs.fuse.userAllowOther = true;

  # See https://nix.dev/permalink/stub-ld.
  #? what is nix-ld?
  # Nix-ld is a tool that allows you to run unpatched dynamic binaries on NixOS.
  # It works by creating a profile that contains the necessary libraries and
  # environment variables to run the binary.
  # It is similar to the `nix run` command, but it does not require
  # the binary to be built with Nix.
  programs.nix-ld = {
    enable = true;
    # Include libstdc++ in the nix-ld profile
    libraries = with pkgs; [
      # Standard compilers & runtime
      gcc # provides /run/current-system/sw/bin/gcc
      libgcc # libgcc_s, etc.
      glibc_multi # if you need multilib support

      stdenv.cc # C compiler environment
      stdenv.cc.cc # explicit cc
      stdenv.cc.cc.lib

      # Common native libraries used during build
      libfontenc
      fontconfig
      freetype
      libxext
      glib
      libpng12
      gcc
      libsm
      libice
      # windows.mcfgthreads
      zlib # compression
      zstd # compression
      xz # compression
      bzip2 # compression
      libssh # SSH support (if needed)
      openssl # TLS, crypto
      libxml2 # XML parsing (if your tooling needs it)
      systemd # for ldconfig and related
      util-linux # mount, etc.
      acl # access-control lists
      attr # file attributes
      curl # downloads
      libxrender
      libx11
      libxrandr

      libGL
      vkd3d
      libva
      libva-utils
      libdrm
      vulkan-loader
      vulkan-validation-layers
      vulkan-extension-layer
    ];
  };

  # List services that you want to enable:
  services = {
    accounts-daemon.enable = true;
    udisks2.enable = true;
    fwupd.enable = true; # Firmware update daemon --- IGNORE ---

    # The color management daemon.
    colord.enable = true;

    # An automatic device mounting daemon.
    devmon.enable = true;

    # A userspace virtual filesystem.
    gvfs.enable = true; # A lot of mpris packages require it.

    # Printing support through the CUPS daemon.
    # printing.enable = false; # Enable CUPS to print documents.
  };

  environment.variables = {
    NIX_AUTO_RUN = "1"; # auto-run programs using nix-index-database
    NIXPKGS_ALLOW_UNFREE = "1"; # support for non-free (proprietary) software.
    NIXPKGS_ALLOW_INSECURE = "1";
    # NIXPKGS_ALLOW_BROKEN = "1"; # allow broken packages to be installed.
    # NIXPKGS_ALLOW_UNFREE_OVERLAYS = "1"; # allow unfree overlays to be used.
    # NIXPKGS_ALLOW_BROKEN_OVERLAYS = "1"; # allow broken overlays to be used.
    NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM = "1";
  };

  home-manager.users.${settings.user.username} = {
    programs.home-manager.enable = true;
    home = {
      sessionPath = [
        "${HOME}/.bin"
        "${HOME}/.local/bin"
        "${HOME}/.cargo/bin"
        "${HOME}/.go/bin"
      ];

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

  environment.systemPackages = with pkgs; [
    # Nix Related Packages
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
    # nixfmt-classic # An opinionated formatter for Nix
    nixos-install-tools # The essential commands from the NixOS installer as a package
    nixos-shell # Spawns lightweight nixos vms in a shell
    nixpkgs-lint # A utility for Nixpkgs contributors to check Nixpkgs for common errors
    nixpkgs-review
    statix # Lints and suggestions for the nix programming language
    deadnix
    cachix

    # Nix language server
    nixd # Feature-rich Nix language server interoperating with C++ nix
    nixfmt
    nil # Yet another language server for Nix
    niv

    # Nix Formatters
    # nixfmt-rfc-style # Official formatter for Nix code [nixfmt file.nix]
    nixpkgs-fmt # Nix code formatter for nixpkgs [nixpkgs-fmt file.nix]

    nixdoc # Generate documentation for Nix functions
    node2nix # Generate Nix expressions to build NPM packages

    # Yet another nix cli helper
    nh

    fwupd
  ];
}
