{ settings, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    (writeShellScriptBin "celluloid-hdr" "celluloid --mpv-profile=HDR $@")
    celluloid
  ];

  home-manager.users."${settings.users.selected.username}" = {
    home.file.".config/celluloid" = {
      source = ./config;
      recursive = true;
    };

    dconf.settings = {
      "io/github/celluloid-player/celluloid" = {
        mpv-config-file =
          "file:///home/${settings.users.selected.username}/.config/celluloid/celluloid.conf";
      };

      "io/github/celluloid-player/celluloid" = { mpv-config-enable = true; };

      "io/github/celluloid-player/celluloid" = {
        always-append-to-playlist = true;
      };
    };
  };
}
