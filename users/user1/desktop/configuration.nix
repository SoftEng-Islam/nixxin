{ settings, lib, pkgs, ... }: {
  imports = [
    ./boot
    ./hardware
    ./environment.nix
    ./home.nix
    ./packages.nix
    ./programs.nix
    ./user.nix
  ];

  system = {
    autoUpgrade.enable = settings.system.upgrade.enable;
    autoUpgrade.allowReboot = settings.system.upgrade.allowReboot;
    autoUpgrade.channel = settings.system.upgrade.channel;
    stateVersion = settings.system.stateVersion;
  };

  # Enable automatic updates
  systemd.timers.nixos-upgrade = {
    enable = true;
    timerConfig.OnCalendar = "weekly";
    wantedBy = [ "timers.target" ];
  };

  systemd.services.nixos-upgrade = {
    script = "${pkgs.nixos-rebuild}/bin/nixos-rebuild switch --upgrade";
    serviceConfig.Type = "oneshot";
  };
}
