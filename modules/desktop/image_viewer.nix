# ---- community.nix ---- #
{
  settings,
  lib,
  pkgs,
  ...
}:
let
  image_viewer = settings.modules.desktop.image_viewer;
  inherit (lib) mkIf;
  _viewers = with pkgs; [
    # https://gitlab.gnome.org/GNOME/eog
    (lib.optional image_viewer.eog.enable eog)

    (lib.optional image_viewer.feh.enable feh)

    #  https://gitlab.gnome.org/GNOME/loupe
    (lib.optional image_viewer.loupe.enable loupe)
  ];
in
mkIf (settings.modules.desktop.image_viewer.enable or false) {
  environment.systemPackages = lib.flatten _viewers;
}
