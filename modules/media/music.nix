{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.media.music) {
  environment.systemPackages = with pkgs; [ mp3fs ];
}
