{ settings, lib, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.flags.enable) {
  home-manager.users.${settings.user.username} = {
    imports = [
      ./chrome-flags.nix
      ./code-flags.nix
      ./electron-flags.nix
      ./msedge-flags.nix
    ];
  };
}
