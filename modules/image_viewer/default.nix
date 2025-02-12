{ settings, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  _imports = [
    (lib.optional settings.modules.image_viewer.eog ./eog.nix)
    (lib.optional settings.modules.image_viewer.feh ./feh.nix)
    (lib.optional settings.modules.image_viewer.loupe ./loupe.nix)
    # (lib.optional settings.modules.image_viewer.LXImage-Qt ./LXImage-Qt.nix)
  ];
in mkIf (settings.modules.image_viewer.enable) {
  imports = lib.flatten _imports;
}
