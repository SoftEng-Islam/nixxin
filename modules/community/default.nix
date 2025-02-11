# ---- community.nix ---- #
{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.community.enable) {
  environment.systemPackages = with pkgs; [
    discord # All-in-one cross-platform voice and text chat for gamers
    ferdium # All your services in one place built by the community
    mumble # Low-latency, high quality voice chat software
    revolt-desktop # Open source user-first chat platform
    signal-desktop # Private, simple, and secure messenger
    slack # Desktop client for Slack
    telegram-desktop # Telegram Desktop messaging app
    vesktop # Alternate client for Discord with Vencord built-in
    zoom-us # zoom.us video conferencing application
  ];
}
