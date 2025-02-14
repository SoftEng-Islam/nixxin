{ settings, lib, pkgs, ... }:
# https://gitlab.gnome.org/GNOME/evince
# https://apps.kde.org/okular/
# https://apps.gnome.org/Papers/

let
  inherit (lib) mkIf;
  _pkgs = with pkgs; [
    # Zathura is a highly customizable and functional PDF viewer based on the poppler rendering library and the GTK toolkit.
    (lib.optional settings.modules.office.documents.zathura zathura)
    # GNOME's document viewer
    (lib.optional settings.modules.office.documents.evince evince)
    # KDE document viewer
    (lib.optional settings.modules.office.documents.okular okular)
    # GNOME's document viewer
    (lib.optional settings.modules.office.documents.papers papers)
  ];
in mkIf (settings.modules.office.documents.enable) {
  environment.systemPackages = lib.flatten _pkgs;
}
