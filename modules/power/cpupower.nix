{ settings, lib, pkgs, ... }:
lib.mkIf (settings.modules.power.cpupower.enable or false) {
  services.cpupower-gui.enable = true; # GUI frontend for CPU governor/freq
  environment.systemPackages = with pkgs; [
    cpupower-gui
    # cpufrequtils
    linuxKernel.packages.linux_zen.perf
    linuxKernel.packages.linux_zen.cpupower
  ];
}
