{ pkgs, ... }: {
  environment.sessionVariables = {
    # MOZ_DBUS_REMOTE = "1";
    MOZ_ENABLE_WAYLAND = "1"; # Ensure Firefox works well on Wayland
  };
  environment.systemPackages = with pkgs; [
    brave # Privacy-oriented browser for Desktop and Laptop computers
    firefox # Web browser built from Firefox source tree
    firefox-beta # Web browser built from Firefox Beta Release source tree
    google-chrome # Freeware web browser developed by Google
    microsoft-edge # The web browser from Microsoft
  ];
}
