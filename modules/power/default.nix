# ------------------------------------------------
# ---- Power Configuration
# ------------------------------------------------
# In this module, we configure power management settings for the system.
# This includes CPU frequency scaling, power management services, and TLP settings.
{
  settings,
  config,
  lib,
  pkgs,
  ...
}:
let
  _power = settings.modules.power;
in
{
  imports = lib.optionals (settings.modules.power.enable or false) [
    ./auto-cpufreq.nix
    ./cpupower.nix
    ./performance.nix
    ./tlp.nix
    ./upower.nix
  ];
  config = lib.mkIf (settings.modules.power.enable or false) (
    lib.mkMerge [
      {
        assertions = [
          {
            assertion = !((_power.auto-cpufreq.enable or false) && (_power.tuned.enable or false));
            message = "Power config: enable either 'modules.power.auto-cpufreq.enable' or 'modules.power.tuned.enable' (not both).";
          }
        ];

        # Disable auto-epp: needs amd-pstate-epp/CPPC support, which this host's CPU
        # may lack (older Zen/Zen+ AMD APUs generally don't expose CPPC). Verify with
        # `cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver` before re-enabling.
        services.auto-epp.enable = false;

        services.thermald.enable = false;
        services.thermald.ignoreCpuidCheck = false;

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
        # - tuned can provide the power-profiles-daemon DBus API via ppdSupport,
        #   so power-profiles-daemon should stay off when tuned is active.
        # - auto-cpufreq.nix always forces the real services.auto-cpufreq.enable
        #   to false regardless of this settings toggle (see that file), so the
        #   toggle alone is not a signal that a competing daemon is running —
        #   don't gate on it here, or you can end up with neither daemon enabled.
        services.power-profiles-daemon.enable = lib.mkDefault (!(_power.tuned.enable or false));

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
          cpufrequtils
        ];
      }
      (lib.mkIf (_power.tuned.enable or false) {
        # sudo tuned-adm profile accelerator-performance
        services.tuned.enable = true;
        services.tuned.settings.dynamic_tuning = true;
        services.tuned.ppdSupport = true; # translation of power-profiles-daemon API calls to TuneD
        services.tuned.ppdSettings.main.default = "performance"; # balanced / performance / power-saver

        systemd.services.tuned-set-profile = {
          description = "Set TuneD profile";
          after = [ "tuned.service" ];
          wantedBy = [ "multi-user.target" ];
          serviceConfig = {
            Type = "oneshot";
            ExecStart = "${pkgs.tuned}/bin/tuned-adm profile accelerator-performance";
          };
        };
      })
    ]
  );
}
