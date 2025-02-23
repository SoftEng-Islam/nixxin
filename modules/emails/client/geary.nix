# https://wiki.gnome.org/Apps/Geary
{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in { environment.systemPackages = with pkgs; [ geary ]; }
