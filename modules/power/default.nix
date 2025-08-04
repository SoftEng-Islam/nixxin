# ------------------------------------------------
# ---- Power Configuration
# ------------------------------------------------
# In this module, we configure power management settings for the system.
# This includes CPU frequency scaling, power management services, and TLP settings.
{ settings, lib, pkgs, ... }:
let _power = settings.modules.power;
in lib.mkIf (_power.enable or true) {
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
  services.auto-epp.enable = true;

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

  # This is the service that lets you pick power profiles in the gnome UI.  It conflicts with auto-cpufreq
  services.power-profiles-daemon.enable = false;
  services.auto-cpufreq.enable = true;

  # Upower, a DBus service that provides power management support to applications.
  services.upower.enable = true;

  # ------------------------------------------------
  # ---- TLP
  # ------------------------------------------------
  # Should You Use TLP on a Desktop?
  #---- No, TLP is designed for laptops to improve battery life by reducing power
  #---- consumption. On a desktop, it is not necessary and can cause performance issues
  #---- by limiting CPU power or turning off USB devices.
  # Don’t use TLP on a desktop. It’s meant for battery-powered devices.
  services.tlp = {
    enable = _power.tlp.enable;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance";
      CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
      CPU_DRIVER_OPMODE_ON_AC = "active";
      CPU_DRIVER_OPMODE_ON_BAT = "active";

      WIFI_PWR_ON_AC = "on";
      WIFI_PWR_ON_BAT = "on";
      RUNTIME_PM_ON_AC = "auto";
      RUNTIME_PM_ON_BAT = "auto";

      CPU_MIN_PERF_ON_AC = 10;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 10;
      CPU_MAX_PERF_ON_BAT = 50;

      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;

      CPU_HWP_DYN_BOOST_ON_AC = 1;
      CPU_HWP_DYN_BOOST_ON_BAT = 0;

      START_CHARGE_THRESH_BAT0 = 75;
      STOP_CHARGE_THRESH_BAT0 = 80;

      MEM_SLEEP_ON_AC = "deep";
      MEM_SLEEP_ON_BAT = "deep";

      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "low-power";

      RADEON_DPM_STATE_ON_AC = "performance";
      RADEON_DPM_STATE_ON_BAT = "battery";
      RADEON_POWER_PROFILE_ON_AC = "high";
      RADEON_POWER_PROFILE_ON_BAT = "low";

      INTEL_GPU_MIN_FREQ_ON_AC = 600;
      INTEL_GPU_MIN_FREQ_ON_BAT = 600;
    };
  };
  environment.systemPackages = with pkgs; [
    upower
    upower-notify
    power-profiles-daemon
    poweralertd
    powercap
    cpupower-gui
    cpufrequtils
  ];
}
