{ settings, config, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.gaming.chess.enable) {
  environment.systemPackages = with pkgs; [ gnome-chess ];
}
