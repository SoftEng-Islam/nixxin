{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;

in mkIf (settings.modules.documents) {
  home-manager.users."${settings.user.username}" = {
    # You code
  };
}
