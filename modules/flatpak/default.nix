{ settings, lib, pkgs, ... }:
# sudo flatpak override --env=FLATPAK_DOWNLOAD_TIMEOUT=600

# To start using flatpaks, particularly for flatpak development:
# $ flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
# $ flatpak update
# $ flatpak search bustle
# $ flatpak install flathub org.freedesktop.Bustle
# $ flatpak run org.freedesktop.Bustle

let inherit (lib) mkIf;
in mkIf (settings.modules.flatpak.enable or false) {
  services.flatpak.enable = true;
  environment.systemPackages = with pkgs; [ flatpak gnome-software ];

  # Flatpak settings
  systemd.tmpfiles.rules = [
    # Increase Flatpak download timeout to 10 minutes
    "w /etc/environment - - - - FLATPAK_DOWNLOAD_TIMEOUT=600"
    # Ensure the cache directory exists and is writable
    "d /var/lib/flatpak/cache 0755 root root -"
  ];

  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  # environment.etc = {
  #   "flatpak/config".text = ''
  #     [Flatpak Config]
  #     # Use a different Flatpak mirror (replace with a fast one for your region)
  #     url=https://mirror.garr.it/mirrors/flathub
  #     # Set a system-wide cache directory for better stability
  #     cache-dir=/var/lib/flatpak/cache
  #   '';
  # };

}
