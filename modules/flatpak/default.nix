{ settings, lib, pkgs, ... }:
# sudo flatpak override --env=FLATPAK_DOWNLOAD_TIMEOUT=600

let inherit (lib) mkIf;
in mkIf (settings.modules.flatpak.enable) {
  services.flatpak.enable = true;

  environment.systemPackages = with pkgs; [ flatpak gnome-software ];

  # Flatpak settings
  systemd.tmpfiles.rules = [
    # Increase Flatpak download timeout to 10 minutes
    "w /etc/environment - - - - FLATPAK_DOWNLOAD_TIMEOUT=600"
    # Ensure the cache directory exists and is writable
    "d /var/lib/flatpak/cache 0755 root root -"
  ];

  environment.etc = {
    "flatpak/config".text = ''
      [Flatpak Config]
      # Use a different Flatpak mirror (replace with a fast one for your region)
      url=https://mirror.garr.it/mirrors/flathub
      # Set a system-wide cache directory for better stability
      cache-dir=/var/lib/flatpak/cache
    '';
  };

}
