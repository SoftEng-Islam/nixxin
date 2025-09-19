{ settings, config, lib, pkgs, ... }:
lib.mkIf (settings.modules.development.tools.enable or false) {
  imports = [ ./editors ];
}
