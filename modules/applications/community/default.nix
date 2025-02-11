# ---- community.nix ---- #
{ settings, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  _cummunity = with pkgs; [
    (lib.optional settings.modules.applications.cummunity.discord discord)
    (lib.optional settings.modules.applications.cummunity.ferdium ferdium)
    (lib.optional settings.modules.applications.cummunity.mumble mumble)
    (lib.optional settings.modules.applications.cummunity.revolt revolt-desktop)
    (lib.optional settings.modules.applications.cummunity.signal signal-desktop)
    (lib.optional settings.modules.applications.cummunity.slack slack)
    (lib.optional settings.modules.applications.cummunity.telegram
      telegram-desktop)
    (lib.optional settings.modules.applications.cummunity.vesktop vesktop)
    (lib.optional settings.modules.applications.cummunity.zoom zoom-us)
  ];
in mkIf (settings.modules.applications.community.enable) {
  environment.systemPackages = lib.flatten _cummunity;
}
