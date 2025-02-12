{ settings, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  _imports = [ (./. + settings.modules.computing.default + ".nix") ];
in mkIf (settings.modules.computing.enable) { imports = lib.flatten _imports; }
