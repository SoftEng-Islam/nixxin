{ lib, settings, pkgs, ... }: {
  imports = [
    # ./clipboard_manager
    # ./color_picker
    ./desktop_environment
    # ./display_configuration
    ./display_manager
    # ./gamma_tools
    # ./keyboard_remapper
    ./networks
    # ./power_menu
    ./qt_gtk
    # ./screen_lock
    # ./screenshot
    ./statusbar
    ./window_manager
    ./audio.nix
    ./boot.nix
    ./corectrl.nix
    ./dbus.nix
    ./dconf.nix
    ./documentation.nix
    ./env.nix
    # ./fcitx5.nix
    ./hardware.nix
    ./home.nix
    ./locale.nix
    ./nix.nix
    ./packages.nix
    ./power.nix
    ./programs.nix
    ./security
    ./services
    ./ssh.nix
    ./systemd.nix
    ./users.nix
    ./utilities.nix
    ./virtualisation.nix
    ./wayland.nix
    ./xdg.nix
    ./zram.nix
  ];
  system = {
    autoUpgrade.enable = settings.system.upgrade.enable;
    autoUpgrade.allowReboot = settings.system.upgrade.allowReboot;
    autoUpgrade.channel = settings.system.upgrade.channel;
    stateVersion = settings.system.stateVersion;
  };
}
