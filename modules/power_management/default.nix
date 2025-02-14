{ lib, ... }: {
  imports = [ ./tlp.nix ./upower.nix ];

  # Power Management
  services.power-profiles-daemon.enable = true;

  powerManagement = {
    enable = true;

    # enable powertop auto tuning on startup.
    powertop.enable = false;

    # Often used values: “ondemand”, “powersave”, “performance”
    cpuFreqGovernor = "performance";
    # cpufreq.min = 800000;
    # cpufreq.max = 2200000;
  };

}
