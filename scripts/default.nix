{
  settings,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./gamemode.nix
    ./networks/wifiMonitorMode.nix
    ./networks/toggleInternet.nix
    ./networks/netShell.nix
    ./changeWallpaper.nix
    ./toggle-services.nix
    ./hyprshade.nix
  ];
}
