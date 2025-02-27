{ pkgs, ... }: {
  # imports = [ ./dunst ];

  environment.systemPackages = with pkgs; [
    # dunst # Lightweight and customizable notification daemon
    notify # Notify allows sending the output from any tool to Slack, Discord and Telegram
    libnotify # A library that sends desktop notifications to a notification daemon
    # avizo # Neat notification daemon for Wayland
  ];
}

