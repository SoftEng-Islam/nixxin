{ settings, pkgs, lib, ... }: {
  imports = lib.optionals (settings.modules.overclock.enable or false) [
    ./corectrl.nix
    ./lactd.nix
  ];

  systemd.services.force-gpu-performance = {
    description = "Force AMD GPU to High Performance Mode";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = [
        "/run/current-system/sw/bin/bash -c 'echo manual > /sys/class/drm/card1/device/power_dpm_force_performance_level'"
        "/run/current-system/sw/bin/bash -c 'echo high > /sys/class/drm/card1/device/power_dpm_force_performance_level'"
      ];
    };
  };

  programs.tuxclocker.enable = false;
  programs.tuxclocker.useUnfree = true;
}
