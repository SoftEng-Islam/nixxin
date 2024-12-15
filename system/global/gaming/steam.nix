{ pkgs, ... }: {
  programs = {

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
    # (mangohud.override { lowerBitnessSupport = true; })
    gamescope # SteamOS session compositing window manager
  ];
}
