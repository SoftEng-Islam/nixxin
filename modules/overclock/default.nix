{ settings, pkgs, lib, ... }: {
  # Useful commands
  # sudo cpupower frequency-info
  # sudo cpupower frequency-set -g performance
  # sudo cpupower frequency-set -g powersave
  # sudo cpupower frequency-set -g schedutil
  # sudo cpupower frequency-set -g userspace
  # sudo cpupower frequency-set -g conservative
  # sudo cpupower frequency-set -g ondemand
  # sudo cpupower frequency-set -g schedutil
  # sudo cpupower frequency-set -g performance --min 2.0GHz --max 4.0GHz
  # sudo cpupower frequency-set -g performance --min 2.0GHz --max 4.0GHz
  # sudo cpupower frequency-set -g performance --min 2.0GHz --max 4.0GHz
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
  environment.systemPackages = with pkgs; [
    msr-tools
    linuxKernel.packages.linux_zen.cpupower
  ];
}
