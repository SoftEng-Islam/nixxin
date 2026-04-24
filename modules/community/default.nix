# ---- community.nix ---- #
{ settings, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  _cummunity = with pkgs; [
    (lib.optional settings.modules.community.discord.enable discord)
    (lib.optional settings.modules.community.ferdium.enable ferdium)
    (lib.optional settings.modules.community.mumble.enable mumble)
    (lib.optional settings.modules.community.revolt.enable revolt-desktop)
    (lib.optional settings.modules.community.signal.enable signal-desktop)
    (lib.optional settings.modules.community.slack.enable slack)
    (lib.optional settings.modules.community.telegram.enable telegram-desktop)
    (lib.optional settings.modules.community.vesktop.enable vesktop)
    (lib.optional settings.modules.community.zoom.enable zoom-us)
  ];
in mkIf (settings.modules.community.enable or false) {
  environment.systemPackages = with pkgs;
    lib.flatten _cummunity ++ [
      zapzap # WhatsApp desktop application written in Pyqt6 + PyQt6-WebEngine.
      caprine-bin # Elegant Facebook Messenger desktop app
    ];
}
