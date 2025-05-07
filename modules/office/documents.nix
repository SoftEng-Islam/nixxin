{ settings, lib, pkgs, ... }:
# https://gitlab.gnome.org/GNOME/evince
# https://apps.kde.org/okular/
# https://apps.gnome.org/Papers/

let
  inherit (lib) mkIf;
  _pkgs = with pkgs; [
    # Zathura is a highly customizable and functional PDF viewer based on the poppler rendering library and the GTK toolkit.
    (lib.optional settings.modules.office.zathura zathura)
    # GNOME's document viewer
    (lib.optional settings.modules.office.evince evince)
    # GNOME's document viewer
    (lib.optional settings.modules.office.papers papers)
  ];
in mkIf (settings.modules.office.enable or false) {
  environment.systemPackages = lib.flatten _pkgs;
}
