# ---- community.nix ---- #
{ settings, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  _cummunity = with pkgs; [
    (lib.optional settings.modules.cummunity.discord discord)
    (lib.optional settings.modules.cummunity.ferdium ferdium)
    (lib.optional settings.modules.cummunity.mumble mumble)
    (lib.optional settings.modules.cummunity.revolt revolt-desktop)
    (lib.optional settings.modules.cummunity.signal signal-desktop)
    (lib.optional settings.modules.cummunity.slack slack)
    (lib.optional settings.modules.cummunity.telegram telegram-desktop)
    (lib.optional settings.modules.cummunity.vesktop vesktop)
    (lib.optional settings.modules.cummunity.zoom zoom-us)
  ];
in mkIf (settings.modules.community.enable) {
  environment.systemPackages = lib.flatten _cummunity;
}
