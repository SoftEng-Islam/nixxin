{
  settings,
  pkgs,
  lib,
  ...
}:
{
  # Useful commands
  # sudo cpupower frequency-info
  # sudo cpupower frequency-set -g performance
  # sudo cpupower frequency-set -g powersave
  # sudo cpupower frequency-set -g schedutil
  # sudo cpupower frequency-set -g userspace
  # sudo cpupower frequency-set -g conservative
  # sudo cpupower frequency-set -g ondemand
  # sudo cpupower frequency-set -g schedutil
  # sudo cpupower frequency-set -g performance --min 2.0GHz --max 4.0GHz
  # sudo cpupower frequency-set -g performance --min 2.0GHz --max 4.0GHz
  # sudo cpupower frequency-set -g performance --min 2.0GHz --max 4.0GHz
  imports = lib.optionals (settings.modules.overclock.enable or false) [
    ./corectrl.nix
    # ./lactd.nix
  ];

  programs.tuxclocker.enable = false;
  programs.tuxclocker.useUnfree = false;

  environment.systemPackages = with pkgs; [
    msr-tools
    linuxKernel.packages.linux_zen.cpupower
    linuxKernel.packages.linux_zen.turbostat
    clinfo
    stress-ng
    pciutils

    # stress -c 4
    stress
  ];
}
