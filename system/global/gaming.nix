{ pkgs, ... }: {
  # hardware.xpadneo.enable = true; # Whether to enable the xpadneo driver for Xbox One wireless controllers.

  programs = {
    gamemode = {
      enable = true;
      enableRenice = true;
      settings = { general = { renice = 20; }; };
    };
    steam = {
      enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true; # Steam Remote Play.
      dedicatedServer.openFirewall = true; # Source Dedicated Server.
      package = pkgs.steam.override {
        extraPkgs = pkgs:
          with pkgs; [
            libgdiplus
            keyutils
            libkrb5
            libpng
            libpulseaudio
            libvorbis
            stdenv.cc.cc.lib
            xorg.libXcursor
            xorg.libXi
            xorg.libXinerama
            xorg.libXScrnSaver
          ];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    steam-run # Run commands in the same FHS environment that is used for Steam
    gamescope # SteamOS session compositing window manager
    # lutris # Open Source gaming platform for GNU/Linux
    gamemode # Optimise Linux system performance on demand
    # protonup
    # retroarch # Multi-platform emulator frontend for libretro cores
    # retroarch-assets
    # retroarch-joypad-autoconfig
    # (mangohud.override { lowerBitnessSupport = true; })

    # Games
    zeroad # Free, open-source game of ancient warfare
  ];
}
