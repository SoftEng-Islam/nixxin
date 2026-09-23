{
  settings,
  lib,
  config,
  pkgs,
  ...
}:
lib.mkIf (settings.modules.power.cpupower.enable or false) {
  environment.systemPackages = with pkgs; [
    cpufrequtils
    perf-tools
    config.boot.kernelPackages.cpupower
    cpupower-gui
  ];
}
