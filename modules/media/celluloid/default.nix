{ settings, lib, config, pkgs, ... }:
let inherit (lib) optionals mkIf;
in mkIf (settings.modules.media.celluloid) {
  environment.systemPackages = with pkgs; [
    (writeShellScriptBin "celluloid-hdr" "celluloid --mpv-profile=HDR $@")
    celluloid
  ];

  home-manager.users.${settings.user.username} = {
    home.file.".config/celluloid" = {
      source = ./config;
      recursive = true;
    };

    dconf.settings = {
      "io/github/celluloid-player/celluloid" = {
        mpv-config-file =
          "file:///home/${settings.user.username}/.config/celluloid/celluloid.conf";
      };

      "io/github/celluloid-player/celluloid" = { mpv-config-enable = true; };

      "io/github/celluloid-player/celluloid" = {
        always-append-to-playlist = true;
      };
    };
  };
}
