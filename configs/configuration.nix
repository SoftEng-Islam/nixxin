# Edit this configuration file to define what should be installed on your system. Help is available in the
# configuration.nix(5) man page and in the NixOS manual (accessible by running ‘nixos-help’).
{ settings, pkgs, ... }:

let
  gnome = if settings.gnome.enable then [ ./modules/wm/gnome ] else [ ];
  hyprland =
    if settings.hyprland.enable then [ ./modules/wm/hyprland ] else [ ];

in { imports = gnome ++ hyprland ++ [ ]; }
