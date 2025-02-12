{ settings, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  _imports = [
    (lib.optional settings.modules.screenshot.flameshot ./flameshot.nix)
    (lib.optional settings.modules.screenshot.slurp ./slurp.nix)
  ];
in mkIf (settings.modules.screenshot.enable) { imports = lib.flatten _imports; }
