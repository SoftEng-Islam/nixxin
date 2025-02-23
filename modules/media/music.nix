{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.music.enable) {
  environment.systemPackages = with pkgs; [ mp3fs ];
}
