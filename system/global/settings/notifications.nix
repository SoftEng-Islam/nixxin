{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    notify # Notify allows sending the output from any tool to Slack, Discord and Telegram
    libnotify # A library that sends desktop notifications to a notification daemon
    dunst # Lightweight and customizable notification daemon
    mako # A lightweight Wayland notification daemon
  ];
}
