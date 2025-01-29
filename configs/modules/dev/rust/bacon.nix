{ settings, pkgs, ... }: {
  home-manager.users.${settings.users.selected.username} = {
    programs.bacon = { enable = true; };
  };
}
