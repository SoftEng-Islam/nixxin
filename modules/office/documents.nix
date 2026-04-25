{
  settings,
  lib,
  pkgs,
  ...
}:
# https://gitlab.gnome.org/GNOME/evince
# https://apps.kde.org/okular/
# https://apps.gnome.org/Papers/

let
  inherit (lib) mkIf;
  _pkgs = with pkgs; [
    # GNOME's document viewer
    (lib.optional settings.modules.office.evince evince)
    # GNOME's document viewer
    (lib.optional settings.modules.office.papers papers)
  ];
in
mkIf (settings.modules.office.enable or false) {
  environment.systemPackages = lib.flatten _pkgs;
}
