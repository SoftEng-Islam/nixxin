{ settings, lib, pkgs, ... }:
lib.mkIf (settings.modules.media.music) {
  environment.systemPackages = with pkgs; [ mp3fs ];
}
