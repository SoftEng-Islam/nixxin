{ lib, ... }: {
  # Power Management
  services.upower.enable = lib.mkForce true;
  services.power-profiles-daemon.enable = true;

  powerManagement = {
    enable = true;
    # powertop.enable = true; # enable powertop auto tuning on startup.
    # Often used values: “ondemand”, “powersave”, “performance”

    cpuFreqGovernor = "performance";
    # cpufreq.min = 800000;
    # cpufreq.max = 2200000;
  };

}
