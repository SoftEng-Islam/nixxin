{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.development.databases.enable) {
  imports = [ ./monogodb ./mysql ./sql ];
}
