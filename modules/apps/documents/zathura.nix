{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;

in mkIf (settings.modules.apps.documents) {
  home-manager.users."${settings.user.username}" = {
    # You code
  };
}
