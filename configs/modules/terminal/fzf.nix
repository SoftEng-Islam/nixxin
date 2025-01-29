{ settings, pkgs, ... }: {
  home-manager.users.${settings.users.selected.username} = {
    programs.fzf = { enable = true; };
  };
}
