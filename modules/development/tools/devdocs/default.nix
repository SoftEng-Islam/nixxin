{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.developement.tools.devdocs.enable) {
  # https://github.com/freeCodeCamp/devdocs
}
