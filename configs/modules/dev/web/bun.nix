{ settings, pkgs, ... }: {
  home-manager.users.${settings.username} = {
    programs.bun = { enable = true; };
  };
}
