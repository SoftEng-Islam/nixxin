{ settings, pkgs, ... }: {
  home-manager.users.${settings.users.selected.username} = {
    programs.bun = { enable = true; };
  };
}
