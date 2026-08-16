# https://github.com/AdnanHodzic/auto-cpufreq
#
# The daemon is intentionally kept off: powerManagement.cpuFreqGovernor
# (modules/power/default.nix) already pins the governor to "performance" via
# NixOS's native cpupower service on this always-plugged-in desktop, so there's
# no dynamic battery/charger switching to gain and no daemon to fight it.
# This module exists purely to install the auto-cpufreq CLI for manual
# `auto-cpufreq --stats` inspection.
#
# NOTE: the nixpkgs auto-cpufreq module gates its OWN package install and
# config-file generation behind `services.auto-cpufreq.enable`, so with that
# set to false here, `services.auto-cpufreq.settings` would never be rendered
# to any file even if set — hence it's omitted entirely below rather than left
# as dead config.
{
  settings,
  lib,
  pkgs,
  ...
}:
lib.mkIf (settings.modules.power.auto-cpufreq.enable or false) {
  services.auto-cpufreq.enable = false;
  environment.systemPackages = with pkgs; [ auto-cpufreq ];
}
