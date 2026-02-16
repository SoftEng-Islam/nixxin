{ settings, lib, pkgs, ... }:
lib.mkIf (settings.modules.power.cpupower.enable or false) {
  environment.systemPackages = with pkgs; [
    cpufrequtils
    perf-tools
    linuxKernel.packages.linux_zen.cpupower
  ];
}
