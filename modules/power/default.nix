{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.power.enable) {
  # ------------------------------------------------
  # ---- Power Configuration
  # ------------------------------------------------
  # Best Power Optimizations for a Desktop
  powerManagement = {
    enable = true;

    # enable powertop auto tuning on startup.
    powertop.enable = false;

    # Often used values: "schedutil", "ondemand", "powersave", "performance"
    #
    # "performance": Runs at max frequency always
    #---- Best for gaming & real-time workloads
    # "powersave": Runs at lowest frequency possible
    #---- Best for battery life
    # "ondemand": Increases frequency when needed
    #---- Older, but decent balance
    # "schedutil": Dynamically scales based on task scheduling
    #---- Best for modern CPUs (recommended)
    #
    cpuFreqGovernor = "schedutil"; # Adaptive CPU scheduling
    #
    # To verify the governor:
    # cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

    # cpufreq.min = 800000;
    # cpufreq.max = 2200000;
  };

  # a DBus daemon that allows changing system behavior based upon user-selected power profiles.
  services.power-profiles-daemon.enable = false;
  # OR
  # Whether to enable auto-cpufreq daemon.
  services.auto-cpufreq.enable = true;

  # Upower, a DBus service that provides power management support to applications.
  services.upower.enable = lib.mkForce true;
  services.upower.package = pkgs.upower;

  # ------------------------------------------------
  # ---- TLP
  # ------------------------------------------------
  # Should You Use TLP on a Desktop?
  #---- No, TLP is designed for laptops to improve battery life by reducing power
  #---- consumption. On a desktop, it is not necessary and can cause performance issues
  #---- by limiting CPU power or turning off USB devices.
  # Don’t use TLP on a desktop. It’s meant for battery-powered devices.
  services.tlp = {
    enable = false;
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
    # ------------------------------------------------
    # ---- Power Packages
    # ------------------------------------------------
    tlp
    upower
    upower-notify
    power-profiles-daemon
    poweralertd
    powercap
  ];
}
