# https://github.com/AdnanHodzic/auto-cpufreq
{ settings, lib, config, pkgs, ... }: {
  services.auto-cpufreq.enable = settings.modules.power.auto-cpufreq.enable;
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
