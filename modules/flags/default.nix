{ settings, ... }: {
  home-manager.users.${settings.user.username} = {
    imports = [
      ./chrome-flags.nix
      ./code-flags.nix
      ./electron-flags.nix
      ./msedge-flags.nix
    ];
  };
}
