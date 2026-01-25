{ settings, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  _pkgs = [
    (lib.optional settings.modules.gaming.zeroad.enable pkgs.zeroad)
    (lib.optional settings.modules.gaming.zeroad.enable pkgs.zeroad-data)
  ];
  # Libraries we want available from nixpkgs (NO wayland here)
  libPath = pkgs.lib.makeLibraryPath [
    pkgs.stdenv.cc.cc # libstdc++.so.6
    pkgs.vulkan-loader # libvulkan.so
    pkgs.vulkan-validation-layers # validation layer runtime
    pkgs.pipewire
    pkgs.sqlite
  ];
in {
  imports = lib.optionals (settings.modules.gaming.enable) [ ./chess.nix ];
  config = mkIf (settings.modules.gaming.enable) {
    nixpkgs.overlays = [
      (final: prev: {
        # --- existing override ---
        nvidia-texture-tools = prev.nvidia-texture-tools.overrideAttrs (old: {
          postPatch = ''
            echo ">>> Fixing CMake minimum version in nvidia-texture-tools ..."
            sed -i '1s/cmake_minimum_required *(VERSION [0-9.]\+)/cmake_minimum_required(VERSION 3.5)/' CMakeLists.txt
          '';

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
            # igpu_high_performance = "yes";
            # igpu_power_control = "yes";
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

    # Enable Vulkan support with proper library paths
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        # Vulkan packages
        vulkan-loader
        vulkan-tools
        vulkan-validation-layers
        vulkan-extension-layer
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [ vulkan-loader vulkan-tools ];
    };

    # Set up Vulkan environment variables
    environment.variables = {
      VK_ICD_FILENAMES =
        "/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json:/run/opengl-driver-32/share/vulkan/icd.d/radeon_icd.i686.json";
      VK_LOADER_DEBUG = "all";
      LD_LIBRARY_PATH =
        lib.mkForce "$LD_LIBRARY_PATH:${libPath}:/run/opengl-driver/lib";
      VK_DRIVER_FILES =
        "/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json";

    };

    environment.systemPackages = with pkgs;
      [
        # 0 A.D. with Vulkan support
        zeroad
        zeroad-data

        # Vulkan tools and libraries
        vulkan-tools
        vulkan-headers
        vulkan-validation-layers
        vulkan-extension-layer

        # Graphics utilities
        vdpauinfo
        clinfo

        # Game optimization
        gamemode

        # ... (rest of your packages)
      ] ++ lib.flatten _pkgs;
  };
}
