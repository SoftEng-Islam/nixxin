# https://github.com/AdnanHodzic/auto-cpufreq
{ settings, lib, config, pkgs, ... }: {
  services.auto-cpufreq.enable = settings.modules.power.auto-cpufreq.enable;
  environment.systemPackages = with pkgs; [ auto-cpufreq ];
}
