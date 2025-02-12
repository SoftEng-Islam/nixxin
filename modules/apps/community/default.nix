# ---- community.nix ---- #
{ settings, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  _cummunity = with pkgs; [
    (lib.optional settings.modules.apps.cummunity.discord discord)
    (lib.optional settings.modules.apps.cummunity.ferdium ferdium)
    (lib.optional settings.modules.apps.cummunity.mumble mumble)
    (lib.optional settings.modules.apps.cummunity.revolt revolt-desktop)
    (lib.optional settings.modules.apps.cummunity.signal signal-desktop)
    (lib.optional settings.modules.apps.cummunity.slack slack)
    (lib.optional settings.modules.apps.cummunity.telegram telegram-desktop)
    (lib.optional settings.modules.apps.cummunity.vesktop vesktop)
    (lib.optional settings.modules.apps.cummunity.zoom zoom-us)
  ];
in mkIf (settings.modules.apps.community.enable) {
  environment.systemPackages = lib.flatten _cummunity;
}
