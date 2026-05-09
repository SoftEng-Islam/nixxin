{
  settings,
  lib,
  ...
}:
let
  inherit (lib)
    optionals
    optional
    flatten
    ;
  js-engines = settings.modules.development.js-engines;
  _imports = [
    (optional js-engines.nodejs.enable ./nodejs.nix)
    (optional js-engines.denojs.enable ./denojs.nix)
  ];
in
{
  imports = optionals (js-engines.enable or false) flatten _imports;
}
