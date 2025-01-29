{ settings, pkgs, ... }: {
  home-manager.users.${settings.users.selected.username} = {
    programs.go = { enable = true; };
  };
}
