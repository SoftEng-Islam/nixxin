{ settings, ... }: {
  home-manager.users.${settings.username} = {
    imports = [
      ./chrome-flags.nix
      ./code-flags.nix
      ./electron-flags.nix
      ./msedge-flags.nix
    ];
  };
}
