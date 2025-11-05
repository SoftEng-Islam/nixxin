{ settings, lib, pkgs, ... }:
lib.mkIf (settings.modules.gaming.chess.enable) {
  environment.systemPackages = with pkgs; [
    gnome-chess
    gnuchess # GNU Chess engine
    chess-tui
    gambit-chess
  ];
}
