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

  # ---------------- #
  # ---- System ---- #
  # ---------------- #
  system = {
    autoUpgrade.enable = true;
    autoUpgrade.allowReboot = true;
    # autoUpgrade.channel = "https://channels.nixos.org/nixos-24.05";
    stateVersion = settings.systemStateVersion;
  };
}
