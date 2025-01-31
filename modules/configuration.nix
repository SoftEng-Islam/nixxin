# Edit this configuration file to define what should be installed on your system. Help is available in the
# configuration.nix(5) man page and in the NixOS manual (accessible by running ‘nixos-help’).
{ lib, settings, pkgs, ... }: {
  imports =
    lib.optional.settings.gnome.enable ./system/desktop_environment/gnome
    ++ lib.optional.settings.COSMIC.enable ./system/desktop_environment/COSMIC
    ++ lib.optional.settings.plasma.enable ./system/desktop_environment/plasma
    ++ lib.optional.settings.hyprland.enable ./system/window_manager/hyprland
    ++ [
      ./android
      ./apps_launcher
      ./cli
      ./desktop
      ./dev
      ./flags
      ./styles
      ./system
      ./terminal
    ] ++ lib.optional.settings.system.features.btop.enable ./btop;
}
