{
  settings,
  lib,
  pkgs,
  ...
}:
let
  _docs = settings.modules.system.docs;
  HOME = settings.HOME;
  nixfmtPackage = if pkgs ? nixfmt then pkgs.nixfmt else pkgs.nixfmt-rfc-style;
in
{

  # For Faster Rebuilding Disable These
  documentation = {
    enable = _docs.enable;
    doc.enable = _docs.doc.enable;
    man.enable = _docs.man.enable;
    man.cache.enable = _docs.man.generateCaches;
    dev.enable = _docs.dev.enable;
    info.enable = _docs.info.enable;
    nixos.enable = _docs.nixos.enable;
  };

  nix.package = pkgs.nixVersions.latest;
  nix.gc.automatic = false;
  nix.gc.dates = "03:15";
  # Keep generations around longer before GC. On a slow link, GC'ing a
  # generation you might roll back to means re-downloading everything
  # in it later. 10d -> 30d costs disk, not bandwidth, so it's a good
  # trade when bandwidth is the scarce resource.
  nix.gc.options = "--delete-older-than 30d";
  nix = {
    settings = {
      # Tell nix to use the xdg spec for base directories
      # while transitioning, any state must be carried over
      # manually, as Nix won't do it for us.
      use-xdg-base-directories = true;

      lint-url-literals = "fatal";

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

      # ---- Slow-connection tuning (500Kib/s - 1Mib/s) ----
      #
      # Fall back to building from source locally when a substitute can't
      # be fetched (times out / cache miss / connection drop). On a fast
      # link this rarely matters; on a slow one it's the difference between
      # a build that finishes and one that hangs retrying a stalled download.
      fallback = true;

      # Give the connection much longer before Nix decides the download
      # has truly stalled. 30s is too aggressive on a slow/flaky link -
      # a big NAR can legitimately go quiet for a while between chunks.
      # 300s (5 min) avoids false-positive retries that waste the bytes
      # you already downloaded.
      stalled-download-timeout = 300;

      # Give TCP/TLS handshakes more room before giving up, since slow
      # links often mean slow/variable latency too, not just low throughput.
      connect-timeout = 60;

      # How many derivations can be substituted (downloaded) at once.
      # Nix's default (16) will happily try to pull that many NARs in
      # parallel, which just slices your 500Kib/s-1Mib/s pipe into tiny
      # shares and makes everything time out. Keep this low so each
      # download actually gets meaningful throughput.
      max-substitution-jobs = 3;

      # How long negative narinfo lookups ("this substituter doesn't have
      # this path") are cached. Longer means fewer repeat round-trips to
      # substituters that are never going to have the package anyway.
      narinfo-cache-negative-ttl = 86400; # 1 day

      # How long flake input tarballs are considered fresh before Nix
      # re-checks upstream for updates. Longer means `nix flake` / rebuild
      # commands don't re-fetch/re-check inputs on every invocation.
      tarball-ttl = 604800; # 1 week

      # If we haven't received data for >= 300s, retry the download
      # (see stalled-download-timeout above - this comment now matches
      # the tuned value rather than the old 30s default).

      # for direnv GC roots
      # Keep build-time-only dependencies around instead of letting the
      # GC roots expire them. On a slow link, re-fetching a compiler or
      # header package you already pulled down for a previous rebuild is
      # far more expensive than the extra disk space costs you.
      keep-outputs = true;
      keep-derivations = true;

      # Don't warn me that my git tree is dirty, I know.
      warn-dirty = false;

      download-buffer-size = 536870912; # 512MiB

      # Use binary cache, this is not Gentoo
      # external builders can also pick up those substituters
      builders-use-substitutes = true;

      # The special value 0 means that the builder should use all available CPU cores in the system.
      cores = 0;

      # Maximum number of parallel TCP connections used to fetch narinfo
      # metadata and imports. Lowered from 35 -> 8: on a 500Kib/s-1Mib/s
      # link, dozens of simultaneous connections just cause contention and
      # timeouts rather than more throughput. Actual NAR download
      # concurrency is separately capped by max-substitution-jobs above.
      http-connections = 8;

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
        "pipe-operators"
        "recursive-nix"
      ];

      trusted-substituters = [ "https://nix-community.cachix.org" ];
      # NOTE (bandwidth): every one of these is queried for narinfo on
      # every derivation Nix evaluates, even ones you never actually pull
      # from that cache. That's small metadata traffic per-substituter,
      # but it adds up to a lot of round trips on a slow link across a
      # full rebuild. If you notice long "querying info about..." pauses,
      # consider trimming this down to just the caches you actually use
      # day-to-day (cache.nixos.org + nix-community cover the vast
      # majority of nixpkgs + community packages) and re-adding the rest
      # only when a specific input needs them.
      substituters = [
        "https://cache.nixos.org" # funny binary cache
        "https://cache.privatevoid.net" # for nix-super
        "https://nix-community.cachix.org" # nix-community cache
        "https://hyprland.cachix.org" # hyprland
        "https://nixpkgs-unfree.cachix.org" # unfree-package cache
        "https://devenv.cachix.org" # devenv cache
        "https://nixpkgs-python.cachix.org" # nixpkgs-python
        "https://nixpkgs-wayland.cachix.org" # nixpkgs-wayland
        "https://attic.xuyh0120.win/lantian"
        "https://yazi.cachix.org"
        "https://noctalia.cachix.org"
      ];

      # Enable cachix
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
        "nixpkgs-python.cachix.org-1:hxjI7pFxTyuTHn2NkvWCrAUcNZLNS3ZAvfYNuYifcEU="
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
        "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
        "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
        "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
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
    # On a slow/metered link, autoUpgrade is even less appealing: a "daily"
    # timer means a full flake-input re-fetch + rebuild every single day
    # whether you're around to babysit it or not. Left as settings-gated
    # below; just flagging it as the biggest bandwidth sink in this file
    # if it's ever flipped on.
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
  };

  # ------------------------------------------------
  # ---- Enable automatic updates
  # ------------------------------------------------
  # Only enable the upgrade timer when system.upgrade.enable is true.
  # Previously this was always enabled, causing unnecessary periodic rebuilds.
  systemd.timers.nixos-upgrade = {
    enable = settings.system.upgrade.enable or false;
    timerConfig.OnCalendar = "weekly";
    wantedBy = [ "timers.target" ];
  };
  systemd.services.nixos-upgrade = {
    enable = settings.system.upgrade.enable or false;
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
    # Keep more generations before nh prunes them, for the same reason as
    # nix.gc.options above - pruning a generation you still want back
    # means re-downloading its closure on a slow link.
    clean.extraArgs = "--keep-since 14d --keep 5";
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
    # Minimal set of libraries for nix-ld.
    # Each library here adds symlinks to the user environment.
    # Only include what's actually needed for unpatched binaries.
    # Removed: gcc (duplicate), glibc_multi, stdenv.cc, stdenv.cc.cc (compilers
    #   belong in environment.systemPackages, not nix-ld), libpng12, systemd,
    #   util-linux, acl, attr, curl, libssh, libva-utils,
    #   vulkan-validation-layers, vulkan-extension-layer (dev/debug only)
    libraries = with pkgs; [
      # Core runtime libraries
      stdenv.cc.cc.lib # libstdc++
      libgcc # libgcc_s

      # Common shared libraries needed by unpatched binaries
      zlib
      zstd
      xz
      bzip2
      openssl
      fontconfig
      freetype
      glib
      libxml2

      # X11/Wayland libraries
      libx11
      libxext
      libxrender
      libxrandr
      libsm
      libice
      libfontenc

      # GPU/Graphics libraries
      libGL
      libdrm
      libva
      vulkan-loader
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
    nixos-install-tools # The essential commands from the NixOS installer as a package
    nixos-shell # Spawns lightweight nixos vms in a shell
    nixpkgs-lint # A utility for Nixpkgs contributors to check Nixpkgs for common errors
    nixpkgs-review
    statix # Lints and suggestions for the nix programming language
    deadnix
    cachix

    # Nix language server
    nixd # Feature-rich Nix language server interoperating with C++ nix
    nixfmtPackage
    nil # Yet another language server for Nix
    niv

    # Nix Formatters
    nixdoc # Generate documentation for Nix functions

    # Yet another nix cli helper
    nh

    fwupd

    nix-converter
  ];
}
