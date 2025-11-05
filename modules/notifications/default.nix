{ settings, config, lib, pkgs, ... }:
let inherit (lib) mkIf;
in {
  imports = [ ./dunst ];

  environment.systemPackages = with pkgs; [
    notify # Notify allows sending the output from any tool to Slack, Discord and Telegram
    libnotify # A library that sends desktop notifications to a notification daemon
    # avizo # Neat notification daemon for Wayland
  ];
}
