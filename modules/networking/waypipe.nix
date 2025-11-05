# https://gitlab.freedesktop.org/mstoeckl/waypipe
{ settings, lib, pkgs, ... }:
lib.mkIf (settings.modules.networking.waypipe or false) {
  environment.systemPackages = with pkgs; [ waypipe ];
}
