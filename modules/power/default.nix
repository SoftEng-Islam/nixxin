# ------------------------------------------------
# ---- Power Configuration
# ------------------------------------------------
# In this module, we configure power management settings for the system.
# This includes CPU frequency scaling, power management services, and TLP settings.
{ settings, config, lib, pkgs, ... }:
let _power = settings.modules.power;
in {
  imports = lib.optionals (settings.modules.power.enable or false) [
    ./auto-cpufreq.nix
    ./cpupower.nix
    ./performance.nix
    ./tlp.nix
    ./upower.nix
  ];
  config = lib.mkIf (settings.modules.power.enable or false) (lib.mkMerge [
    {
      assertions = [{
        assertion = !((_power.auto-cpufreq.enable or false)
          && (_power.tuned.enable or false));
        message =
          "Power config: enable either 'modules.power.auto-cpufreq.enable' or 'modules.power.tuned.enable' (not both).";
      }];

      boot.kernelModules = settings.modules.power.boot.kernelModules or [
        # "acpi_cpufreq" # ACPI CPU frequency scaling driver
        # "cpufreq_performance" # Performance CPU frequency scaling driver
        # "cpufreq_powersave" # Powersave CPU frequency scaling driver
        # "cpufreq_ondemand" # On-demand CPU frequency scaling driver
        # "cpufreq_conservative" # Conservative CPU frequency scaling driver
        # "powernow-k8" # AMD PowerNow! driver for CPU frequency scaling
      ];

      boot.kernelParams = settings.modules.power.boot.kernelParams or [ ];

      # Enable auto-epp for amd active pstate.
      services.auto-epp.enable = false;

      services.thermald.enable = true;

      # Enable the ACPI power management daemon.
      services.acpid.enable = true;

      # Whether to enable power management. This includes support for suspend-to-RAM and powersave features on laptops.
      powerManagement.enable = _power.powerManagement.enable;

      # Enable powertop auto tuning on startup.
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

      # powerprofilesctl provider:
      # - auto-cpufreq conflicts with power-profiles-daemon (and also tends to
      #   fight with tuned/cpupower).
      # - tuned can provide the power-profiles-daemon DBus API via ppdSupport.
      services.power-profiles-daemon.enable = lib.mkDefault
        (!(_power.auto-cpufreq.enable or false)
          && !(_power.tuned.enable or false));

      powerManagement.scsiLinkPolicy = "max_performance";

      environment.systemPackages = with pkgs; [
        acpi
        acpic
        acpid
        acpitool
        acpica-tools
        acpidump-all
        power-profiles-daemon
        poweralertd
        cpupower-gui
        cpufrequtils
      ];
    }
    (lib.mkIf (_power.tuned.enable or false) {
      # sudo tuned-adm profile accelerator-performance
      services.tuned.enable = true;
      services.tuned.settings.dynamic_tuning = true;
      services.tuned.ppdSupport =
        true; # translation of power-profiles-daemon API calls to TuneD
      services.tuned.ppdSettings.main.default =
        "performance"; # balanced / performance / power-saver

      systemd.services.tuned-set-profile = {
        description = "Set TuneD profile";
        after = [ "tuned.service" ];
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          Type = "oneshot";
          ExecStart =
            "${pkgs.tuned}/bin/tuned-adm profile accelerator-performance";
        };
      };
    })
  ]);
}
