# Edit this configuration file to define what should be installed on your system. Help is available in the
# configuration.nix(5) man page and in the NixOS manual (accessible by running ‘nixos-help’).
{ lib, settings, pkgs, ... }: {
  imports = (lib.optionals settings.system.features.btop.enable [ ./btop ]) ++ [
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
  environment.systemPackages = with pkgs;
    [ inputs.ignis.packages.${system}.ignis ];
  home-manager.users."${settings.users.selected.username}" = {
    home.file.".config/ignis".source = ./ignis;
  };
}
