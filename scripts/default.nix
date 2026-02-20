{ settings, lib, pkgs, ... }: {
  imports = [
    ./gamemode.nix
    ./networks/wifiMonitorMode.nix
    ./networks/toggleInternet.nix
    ./changeWallpaper.nix
    ./ffmpeg.nix
    ./toggle-services.nix
    ./hyprshade.nix
  ];
}
