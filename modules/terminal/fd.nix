{ settings, pkgs, ... }: {
  home-manager.users.${settings.users.selected.username} = {
    programs.fd = { enable = true; };
  };
}
