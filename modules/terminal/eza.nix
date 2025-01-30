{ settings, pkgs, ... }: {
  home-manager.users.${settings.users.selected.username} = {
    programs.eza = { enable = true; };
  };
}
