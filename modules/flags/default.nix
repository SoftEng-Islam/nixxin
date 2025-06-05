{ settings, lib, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.flags.enable) {
  home-manager.users.${settings.user.username} = {
    imports = [ ./electron-flags.nix ];
  };
}
