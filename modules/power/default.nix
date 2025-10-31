# ------------------------------------------------
# ---- Power Configuration
# ------------------------------------------------
# In this module, we configure power management settings for the system.
# This includes CPU frequency scaling, power management services, and TLP settings.
{ settings, config, lib, pkgs, ... }:
let _power = settings.modules.power;
in {
  imports = lib.optionals (settings.modules.power.enable or true) [
    ./auto-cpufreq.nix
    ./cpupower.nix
    ./performance.nix
    ./tlp.nix
    ./upower.nix
  ];
  config = lib.mkIf (settings.modules.power.enable or true) {

    boot.kernelModules = settings.modules.power.boot.kernelModules or [
      "acpi_cpufreq" # ACPI CPU frequency scaling driver
      "cpufreq_performance" # Performance CPU frequency scaling driver
      "cpufreq_powersave" # Powersave CPU frequency scaling driver
      "cpufreq_ondemand" # On-demand CPU frequency scaling driver
      "cpufreq_conservative" # Conservative CPU frequency scaling driver
      "powernow-k8" # AMD PowerNow! driver for CPU frequency scaling
    ];

    boot.kernelParams = settings.modules.power.boot.kernelParams or [ ];

    # Enable auto-epp for amd active pstate.
    services.auto-epp.enable = false;

    services.thermald.enable = true;

    # Whether to enable power management. This includes support for suspend-to-RAM and powersave features on laptops.
    powerManagement.enable = _power.powerManagement.enable;

    # enable powertop auto tuning on startup.
    powerManagement.powertop.enable = _power.powerManagement.powertop;

    # Often used values: "schedutil", "ondemand", "powersave", "performance".
    # [performance]: Runs at max frequency always :: Best for gaming & real-time workloads
    # [powersave]: Runs at lowest frequency possible :: Best for battery life
    # [ondemand]: Increases frequency when needed :: Older, but decent balance
    # [schedutil]: Dynamically scales based on task scheduling :: Best for modern CPUs (recommended)
    powerManagement.cpuFreqGovernor = _power.powerManagement.cpuFreqGovernor;

    # powerManagement.cpufreq.min = _power.powerManagement.cpufreq.min;
    # powerManagement.cpufreq.max = _power.powerManagement.cpufreq.max;
    # To verify/check the current CPU frequency:
    # cat /sys/devices/system/cpu/cpufreq/scaling_governor

    # This is the service that lets you pick power profiles in the gnome UI.
    #! It conflicts with auto-cpufreq
    services.power-profiles-daemon.enable = false;

    environment.systemPackages = with pkgs; [
      power-profiles-daemon
      poweralertd
      powercap
      cpupower-gui
      cpufrequtils
    ];
  };
}
