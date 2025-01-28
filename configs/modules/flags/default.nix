{ settings, ... }: {
  home-manager.users.${settings.users.user1.username} = {
    imports = [
      ./chrome-flags.nix
      ./code-flags.nix
      ./electron-flags.nix
      ./msedge-flags.nix
    ];
  };
}
