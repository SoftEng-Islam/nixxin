# https://gitlab.freedesktop.org/mstoeckl/waypipe
{ settings, lib, pkgs, ... }: {
  environment.systemPackages = with pkgs; [ waypipe ];
}
