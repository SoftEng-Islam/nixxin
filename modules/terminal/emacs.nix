{ settings, pkgs, ... }: {
  home-manager.users.${settings.users.selected.username} = {
    programs.emacs = { enable = true; };
  };
}
