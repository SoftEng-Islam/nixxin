{ settings, pkgs, ... }: {
  home-manager.users.${settings.users.selected.username} = {
    programs.dircolors = { enable = true; };
  };
}
