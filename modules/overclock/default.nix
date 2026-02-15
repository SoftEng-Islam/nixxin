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

  # This startup script forces the Boost State to "1" on every boot
  system.activationScripts.forceTurbo = ''
    if [ -e /sys/devices/system/cpu/cpufreq/boost ]; then
      echo 1 > /sys/devices/system/cpu/cpufreq/boost
    fi
  '';

  # 5. STARTUP SCRIPT: The final MSR flip
  systemd.services.force-turbo = {
    description = "Force AMD Turbo Core and Performance mode";
    wantedBy = [ "multi-user.target" ];
    script = ''
      # Ensure boost is enabled in sysfs
      if [ -e /sys/devices/system/cpu/cpufreq/boost ]; then
        echo 1 > /sys/devices/system/cpu/cpufreq/boost
      fi
      # Optional: Rewrite MSR to ensure hardware is awake
      ${pkgs.msr-tools}/bin/wrmsr -a 0xc0010015 0x09001011
    '';
    serviceConfig.Type = "oneshot";
  };

  programs.tuxclocker.enable = true;
  programs.tuxclocker.useUnfree = true;
  environment.systemPackages = with pkgs; [
    msr-tools
    linuxKernel.packages.linux_zen.cpupower
    linuxKernel.packages.linux_zen.turbostat
    clinfo
    stress-ng
    pciutils
    # stress -c 4
    stress
  ];
}
