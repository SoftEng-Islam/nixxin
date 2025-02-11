{ settings, lib, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Browsers
    brave # Privacy-oriented browser for Desktop and Laptop computers
    firefox-beta # Web browser built from Firefox Beta Release source tree
    google-chrome # Freeware web browser developed by Google
    microsoft-edge # The web browser from Microsoft
  ];
}
