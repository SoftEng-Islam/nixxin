{ settings, pkgs, ... }: {
  home-manager.users.${settings.username} = {
    programs.direnv = { enable = true; };
  };
}
