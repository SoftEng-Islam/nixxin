{ settings, pkgs, ... }: {
  home-manager.users.${settings.users.user1.username} = {
    programs.bacon = { enable = true; };
  };
}
