{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    discord # All-in-one cross-platform voice and text chat for gamers
    zoom-us # zoom.us video conferencing application
    ferdium # All your services in one place built by the community
    mumble # Low-latency, high quality voice chat software
    signal-desktop # Private, simple, and secure messenger
    slack # Desktop client for Slack
    telegram-desktop # Telegram Desktop messaging app

  ];
}
