{ settings, lib, pkgs, ... }: {
  imports = [
    # ./detect_mouse_position.nix
    ./gamemode.nix
    ./networks/wifiMonitorMode.nix
    ./networks/toggleInternet.nix
  ];
}
