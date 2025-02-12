{ settings, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  _imports = [
    (lib.optional settings.modules.apps.screenshot.flameshot ./flameshot.nix)
    (lib.optional settings.modules.apps.screenshot.slurp ./slurp.nix)
  ];
in mkIf (settings.modules.apps.screenshot.enable) {
  imports = lib.flatten _imports;
}
