# https://github.com/AdnanHodzic/auto-cpufreq
{ settings, lib, pkgs, ... }:
lib.mkIf (settings.modules.power.auto-cpufreq.enable or false) {
  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
      governor = "powersave";
      turbo = "never";
    };
    charger = {
      governor = "performance";
      turbo = "auto";
    };
  };
  environment.systemPackages = with pkgs; [ auto-cpufreq ];
}
