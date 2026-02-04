# https://github.com/AdnanHodzic/auto-cpufreq
{ settings, lib, pkgs, ... }:
lib.mkIf (settings.modules.power.auto-cpufreq.enable or false) {
  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
      governor = "performance";
      turbo = "always";
      scaling_max_freq = 3900000;
    };
    charger = {
      governor = "performance";
      turbo = "always";
      scaling_max_freq = 3900000;
      energy_performance_preference = "performance";
    };
  };
  environment.systemPackages = with pkgs; [ auto-cpufreq ];
}
