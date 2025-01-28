{ settings, pkgs, ... }: {
  home-manager.users.${settings.users.user1.username} = {
    programs.bun = { enable = true; };
  };
}
