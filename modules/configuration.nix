# Edit this configuration file to define what should be installed on your system. Help is available in the
# configuration.nix(5) man page and in the NixOS manual (accessible by running ‘nixos-help’).
{ lib, settings, pkgs, ... }: {
  imports = (lib.optional settings.system.features.btop.enable [ ./btop ]) ++ [
    ./android
    ./apps_launcher
    ./cli
    ./desktop
    ./dev
    ./flags
    ./styles
    ./system
    ./terminal
  ];
}
