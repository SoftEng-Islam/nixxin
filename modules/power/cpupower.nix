{ settings, lib, pkgs, ... }:
lib.mkIf (settings.modules.power.cpupower.enable or false) {
  # Writes to /etc/sysctl.d/60-nixos.conf
  boot.kernel.sysctl = {
    # Enable all magic sysrq commands (NixOS sets this to 16, which enables sync only)
    "kernel.sysrq" = 1;
    "vm.swappiness" = 20; # balanced setting favoring RAM usage, Default=60
  };
  services.cpupower-gui.enable = true;
  environment.systemPackages = with pkgs; [
    cpupower-gui
    cpufrequtils
    linuxKernel.packages.linux_zen.perf
    linuxKernel.packages.linux_zen.cpupower
  ];
}
