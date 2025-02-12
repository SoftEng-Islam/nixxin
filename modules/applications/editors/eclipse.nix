{ settings, pkgs, ... }: {
  home-manager.users.${settings.user.username} = {
    programs.eclipse = { enable = true; };
  };
}
