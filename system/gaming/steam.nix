{ pkgs, ... }: {
  hardware.xpadneo.enable = true;

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
    (mangohud.override { lowerBitnessSupport = true; })
    gamescope # SteamOS session compositing window manager
    gamemode # Optimise Linux system performance on demand
  ];
}
