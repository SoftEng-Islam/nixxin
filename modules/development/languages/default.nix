{ settings, lib, ... }:
let
  inherit (lib)
    optional
    flatten
    ;
  development = settings.modules.development;
  _imports = [
    (optional development.rust ./python.nix)
    (optional development.rust ./ruby.nix)
    (optional development.rust ./rust.nix)
  ];
in
{
  imports = flatten _imports;
}
