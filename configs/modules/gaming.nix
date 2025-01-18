{ pkgs, ... }: {
  programs = {
    gamemode = {
      enable = true;
      enableRenice = true;
      settings = {
        general = {
          desiredgov = "performance";
          renice = 20;
        };
        custom = {
          start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
          end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
          script_timeout = 10;
        };
      };
    };
    steam = {
      enable = false;
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

  environment.systemPackages = with pkgs; [
    # steam-run # Run commands in the same FHS environment that is used for Steam
    # gamescope # SteamOS session compositing window manager
    # lutris # Open Source gaming platform for GNU/Linux
    # retroarch # Multi-platform emulator frontend for libretro cores
    # retroarch-assets # Assets needed for RetroArch
    # retroarch-joypad-autoconfig # Joypad autoconfig files
    # (mangohud.override { lowerBitnessSupport = true; })
    gamemode # Optimise Linux system performance on demand

    # CLI program and API to automate the installation and update of GloriousEggroll's Proton-GE
    # protonup

    # Games
    zeroad # Free, open-source game of ancient warfare
  ];
}
