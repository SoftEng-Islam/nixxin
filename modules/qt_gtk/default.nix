{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.qt_gtk.enable) {
  imports = [
    ./gtk.nix
    ./qt.nix
    # ./qt_gtk.nix
  ];
}
