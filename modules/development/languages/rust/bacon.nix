{ settings, pkgs, ... }: {
  home-manager.users.${settings.user.username} = {
    programs.bacon = { enable = true; };
  };
}
