{ settings, pkgs, ... }: {
  home-manager.users.${settings.username} = {
    programs.eclipse = { enable = true; };
  };
}
