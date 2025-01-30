# Edit this configuration file to define what should be installed on your system. Help is available in the
# configuration.nix(5) man page and in the NixOS manual (accessible by running ‘nixos-help’).
{ settings, pkgs, ... }:
let
  gnome = if settings.gnome.enable then
    [ ./system/desktop_environment/gnome ]
  else
    [ ];
  COSMIC = if settings.COSMIC.enable then
    [ ./system/desktop_environment/COSMIC ]
  else
    [ ];
  plasma = if settings.plasma.enable then
    [ ./system/desktop_environment/plasma ]
  else
    [ ];
  hyprland = if settings.hyprland.enable then
    [ ./system/window_manager/hyprland ]
  else
    [ ];

in {
  imports = gnome ++ COSMIC ++ plasma ++ hyprland ++ [
    ./android
    ./apps_launcher
    (if settings.system.features.btop.enable then ./btop else null)
    ./cli
    ./desktop
    ./dev
    ./flags
    ./styles
    ./system
    ./terminal
  ];
}
