# ---- community.nix ---- #
{ settings, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  _cummunity = with pkgs; [
    (lib.optional settings.modules.community.discord discord)
    (lib.optional settings.modules.community.ferdium ferdium)
    (lib.optional settings.modules.community.mumble mumble)
    (lib.optional settings.modules.community.revolt revolt-desktop)
    (lib.optional settings.modules.community.signal signal-desktop)
    (lib.optional settings.modules.community.slack slack)
    (lib.optional settings.modules.community.telegram telegram-desktop)
    (lib.optional settings.modules.community.vesktop vesktop)
    (lib.optional settings.modules.community.zoom zoom-us)
  ];
in mkIf (settings.modules.community.enable) {
  environment.systemPackages = lib.flatten _cummunity;
}
