{ settings, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  _pkgs = [
    (lib.optional settings.modules.gaming.zeroad.enable pkgs.zeroad)
    (lib.optional settings.modules.gaming.zeroad.enable pkgs.zeroad-data)
  ];
in {
  imports = lib.optionals (settings.modules.gaming.enable) [ ./chess.nix ];
  config = mkIf (settings.modules.gaming.enable) {
    nixpkgs.overlays = [
      (final: prev: {
        nvidia-texture-tools = prev.nvidia-texture-tools.overrideAttrs (old: {
          postPatch = ''
            echo ">>> Fixing CMake minimum version in nvidia-texture-tools ..."
            # Match both "2.6" and "2.8" or any similar low version
            sed -i '1s/cmake_minimum_required *(VERSION [0-9.]\+)/cmake_minimum_required(VERSION 3.5)/' CMakeLists.txt
          '';

          # Add the required policy flag to CMake
          cmakeFlags = (old.cmakeFlags or [ ])
            ++ [ "-DCMAKE_POLICY_VERSION_MINIMUM=3.5" ];
        });
      })
    ];

    programs = {
      gamemode = {
        # https://feralinteractive.github.io/gamemode/
        enable = true;
        enableRenice = true;
        settings = {
          general = {
            ioprio = 0;
            renice = 20;
            softrealtime = "auto";
            inhibit_screensaver = 1;
            desiredgov = "performance"; # "performance"
          };
          gpu = {
            apply_gpu_optimisations = "accept-responsibility";
            gpu_device = 1;
            amd_performance_level = "high";
            nv_powermizer_mode = 1;
            # APU specific settings
            igpu_power_control = "yes";
            igpu_high_performance = "yes";
          };
          custom = {
            start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
            end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
            script_timeout = 10;
          };
        };
      };
      steam = {
        enable = settings.modules.gaming.steam.enable;
        protontricks.enable = true;
        gamescopeSession.enable = true;
        remotePlay.openFirewall = true; # Steam Remote Play.
        dedicatedServer.openFirewall = true; # Source Dedicated Server.
        package = pkgs.steam.override {
          extraPkgs = [
            pkgs.keyutils
            pkgs.libgdiplus
            pkgs.libkrb5
            pkgs.libpng
            pkgs.libpulseaudio
            pkgs.libvorbis
            pkgs.stdenv.cc.cc.lib
            pkgs.xorg.libXcursor
            pkgs.xorg.libXi
            pkgs.xorg.libXinerama
            pkgs.xorg.libXScrnSaver
          ];
        };
      };
    };

    services.sunshine = {
      enable = false;
      autoStart = true;
      capSysAdmin = true;
      openFirewall = true;
    };

    programs.gamescope.enable = true;
    # Whether to add `cap_sys_nice` capabilities to GameScope, so that it may renice itself.
    programs.gamescope.capSysNice = true;

    home-manager.users.${settings.user.username} = {
      xdg.desktopEntries."0ad" = {
        name = "0 A.D.";
        genericName = "Historical RTS";
        exec = "gamescope -f -w 1920 -h 1080 -r 60 -- 0ad %u";
        icon = "0ad";
        categories = [ "Game" "StrategyGame" ];
      };
    };

    environment.systemPackages = with pkgs;
      [
        # steam-run # Run commands in the same FHS environment that is used for Steam
        # gamescope # SteamOS session compositing window manager
        # lutris # Open Source gaming platform for GNU/Linux
        # retroarch # Multi-platform emulator frontend for libretro cores
        # retroarch-assets # Assets needed for RetroArch
        # retroarch-joypad-autoconfig # Joypad autoconfig files
        # (mangohud.override { lowerBitnessSupport = true; })
        gamemode # Optimise Linux system performance on demand

        gamescope

        # Yet another keyboard configurator
        # via

        # Install Gaming & Benchmarking Tools
        vulkan-tools # Tests Vulkan performance
        vkmark # Vulkan benchmark
        mesa-demos # OpenGL test tools
        mesa_i686 # Extra OpenGL tools

        boost
        icu
        libpng

        # CLI program and API to automate the installation and update of GloriousEggroll's Proton-GE
        # protonup
      ] ++ lib.flatten _pkgs;
  };
}
