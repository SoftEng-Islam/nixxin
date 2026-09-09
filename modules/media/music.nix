{
  settings,
  lib,
  pkgs,
  ...
}:
lib.mkIf (settings.modules.media.music) {
  environment.systemPackages = with pkgs; [
    spotify
    mp3fs
    # Sound Player
    # recordbox # Relatively simple music player
  ];
}
