{ settings, pkgs, ... }: {
  imports = [
    ./audio.nix
    ./corectrl.nix
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
    #./tuigreet.nix
    ./users.nix
    ./utilities.nix
    ./virtualisation.nix
    ./zram.nix
  ];
}
