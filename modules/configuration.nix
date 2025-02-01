# Edit this configuration file to define what should be installed on your system. Help is available in the
# configuration.nix(5) man page and in the NixOS manual (accessible by running ‘nixos-help’).
{ lib, inputs, settings, pkgs, ... }: {
  imports = (lib.optionals settings.system.features.btop.enable [ ./btop ]) ++ [
    ./android
    ./apps_launcher
    ./cli
    ./desktop
    ./dev
    ./flags
    ./ignis
    ./styles
    ./system
    ./terminal
  ];
}
