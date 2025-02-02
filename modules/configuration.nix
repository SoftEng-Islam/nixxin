# Edit this configuration file to define what should be installed on your system. Help is available in the
# configuration.nix(5) man page and in the NixOS manual (accessible by running ‘nixos-help’).
{ lib, inputs, settings, pkgs, ... }: {
  imports = [
    # [Folders]
    ./android
    ./audio
    ./btop
    ./cli
    ./desktop_environment
    ./dev
    ./display_manager
    ./editors
    ./fileManager
    ./flags
    ./graphics
    ./ignis
    ./image_viewer
    ./media
    ./networks
    ./notification_daemon
    ./qbittorrent
    ./qt_gtk
    ./security
    ./services
    ./styles
    ./terminal
    ./window_manager

    # [Files]
    ./applications.nix
    ./boot.nix
    ./corectrl.nix
    ./data-transferring.nix
    ./dbus.nix
    ./dconf.nix
    ./documentation.nix
    ./env.nix
    ./gaming.nix
    ./hardware.nix
    ./home.nix
    ./locale.nix
    ./misc.nix
    ./nix.nix
    ./packages.nix
    ./power.nix
    ./programs.nix
    ./ssh.nix
    ./system.nix
    ./systemd.nix
    ./users.nix
    ./utilities.nix
    ./virtualisation.nix
    ./wayland.nix
    ./wine.nix
    ./xdg.nix
    ./zram.nix
  ];
}
