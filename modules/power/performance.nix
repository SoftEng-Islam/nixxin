{ settings, lib, pkgs, ... }:
lib.mkIf (settings.modules.power.performance.enable or false) {
  # system.activationScripts = {
  #   # Limit CPU frequency to 4GHz
  #   fixCpuFreq = ''
  #     for cpu in /sys/devices/system/cpu/cpu[0-9]*; do
  #       if [ -d "$cpu/cpufreq" ]; then
  #         echo "Setting frequency limits for $(basename "$cpu")"
  #         echo 4000000 > "$cpu/cpufreq/scaling_max_freq"
  #         echo 4000000 > "$cpu/cpufreq/scaling_min_freq"
  #       fi
  #     done
  #   '';
  # };

  # Work around performance issues with amdgpu power scaling
  # https://wiki.archlinux.org/title/AMDGPU#Screen_artifacts_and_frequency_problem
  # https://wiki.archlinux.org/title/AMDGPU#Power_profiles
  # 0=BOOTUP_DEFAULT 1=3D_FULL_SCREEN 2=POWER_SAVING 3=VIDEO 4=VR 5=COMPUTE 6=CUSTOM
  #!! cardX or renderX must match the correct gpu
  #?? lspci
  #?? ls -l /dev/dri/by-path/*
  #?? sudo udevadm trigger /dev/dri/by-path/*
  #?? grep '*' /sys/class/drm/card*/device/pp_power_profile_mode
  # KERNEL=="renderD128", SUBSYSTEM=="drm", DRIVERS=="amdgpu", ATTR{device/power_dpm_force_performance_level}="manual", ATTR{device/pp_power_profile_mode}="4"
  # services.udev.extraRules = ''
  # KERNEL=="card1", SUBSYSTEM=="drm", DRIVER=="amdgpu", ATTR{power_dpm_force_performance_level}="manual", ATTR{device/pp_power_profile_mode}="5"
  # '';
}
