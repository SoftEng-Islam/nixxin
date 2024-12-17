{ pkgs, ... }: {
  programs = {
    gamemode = {
      enable = true;
      enableRenice = true;
      settings = { general = { renice = 20; }; };
    };
    steam = {
      enable = false;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true; # Steam Remote Play.
      dedicatedServer.openFirewall = true; # Source Dedicated Server.
      package = pkgs.steam.override {
        extraPkgs = pkgs:
          with pkgs;
          [
            # keyutils
            # libgdiplus
            # libkrb5
            # libpng
            # libpulseaudio
            # libvorbis
            # stdenv.cc.cc.lib
            # xorg.libXcursor
            # xorg.libXi
            # xorg.libXinerama
            # xorg.libXScrnSaver
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
