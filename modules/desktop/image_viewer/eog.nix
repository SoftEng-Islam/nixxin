# https://gitlab.gnome.org/GNOME/eog
{ settings, pkgs, ... }: {
  environment.systemPackages = with pkgs; [ eog ];
}
