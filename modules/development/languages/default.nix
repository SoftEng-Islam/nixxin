{ settings, lib, ... }:
let
  inherit (lib)
    optional
    flatten
    ;
  languages = settings.modules.development.languages;
  _imports = [
    (optional languages.python.enable ./python.nix)
    (optional languages.ruby.enable ./ruby.nix)
    (optional languages.rust.enable ./rust.nix)
    (optional languages.go.enable ./go.nix)
  ];
in
{
  imports = flatten _imports;
}
