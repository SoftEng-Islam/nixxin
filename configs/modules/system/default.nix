{ settings, pkgs, ... }: {
  imports = [
    ./audio.nix
    ./boot.nix
    ./dbus.nix
    ./dm.nix
    ./env.nix
    ./locale.nix
    ./networking.nix
    ./power.nix
    ./programs.nix
    # ./sddm.nix
    ./security.nix
    ./services.nix
    ./systemd.nix
    ./users.nix
    ./utilities.nix
    ./virtualisation.nix
    ./zram.nix
  ];
}
