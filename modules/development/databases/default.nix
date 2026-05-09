{
  settings,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib)
    optional
    flatten
    ;
  databases = settings.modules.development.databases;

  _imports = [
    (optional databases.postgresql.enable ./postgresql.nix)
    (optional databases.mongodb.enable ./mongodb.nix)
    (optional databases.tools.enable ./tools.nix)
  ];
in
{
  imports = flatten _imports;
}
