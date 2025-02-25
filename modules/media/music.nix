{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.media.music.enable) {
  environment.systemPackages = with pkgs; [ mp3fs ];
}
