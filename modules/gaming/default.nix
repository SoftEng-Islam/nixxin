{
  settings,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
in
{
  imports = lib.optionals (settings.modules.gaming.enable or false) [
    ./chess.nix
    ./zeroad.nix
  ];

  config = mkIf (settings.modules.gaming.enable or false) {
    nixpkgs.overlays = [
      (final: prev: {
        nvidia-texture-tools = prev.nvidia-texture-tools.overrideAttrs (old: {
          postPatch = ''
            echo ">>> Fixing CMake minimum version in nvidia-texture-tools ..."
            sed -i '1s/cmake_minimum_required *(VERSION [0-9.]\+)/cmake_minimum_required(VERSION 3.5)/' CMakeLists.txt
          '';
          cmakeFlags = (old.cmakeFlags or [ ]) ++ [ "-DCMAKE_POLICY_VERSION_MINIMUM=3.5" ];
        });
      })
    ];

    # Environment variables for Steam & GE-Proton compatibility
    environment.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    };

    programs = {
      # Performance overlay
      mangohud.enable = true;

      # GameScope compositor
      gamescope = {
        enable = true;
        capSysNice = true;
      };

      # GameMode optimization daemon
      gamemode = {
        enable = true;
        enableRenice = true;
        settings = {
          general = {
            ioprio = 0;
            renice = -10;
            softrealtime = "auto";
            inhibit_screensaver = 1;
            desiredgov = "performance";
          };
          gpu = {
            apply_gpu_optimisations = "accept-responsibility";
            gpu_device = 0; # Set to 0 for primary/integrated GPU
            amd_performance_level = "high";
            nv_powermizer_mode = 1;
          };
          custom = {
            start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
            end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
            script_timeout = 10;
          };
        };
      };

      # Steam client setup
      steam = {
        enable = settings.modules.gaming.steam.enable;
        protontricks.enable = true;
        gamescopeSession.enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
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

    # Graphics drivers & Vulkan 32-bit/64-bit translation layer
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        vulkan-tools
        vulkan-validation-layers
        vulkan-extension-layer
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [
        vulkan-tools
      ];
    };

    # System-wide utilities
    environment.systemPackages = with pkgs; [
      clinfo
      protonup-qt # GUI to easily install GE-Proton for Steam
      vdpauinfo
      vulkan-tools
    ];
  };
}
