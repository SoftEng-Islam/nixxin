{ lib, ... }: {
  imports = [ ./tlp.nix ./upower.nix ];

  # Power Management
  services.power-profiles-daemon.enable = true;

  # Whether to enable auto-cpufreq daemon.
  services.auto-cpufreq.enable = true;

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

}
