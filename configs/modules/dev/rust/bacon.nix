{ settings, pkgs, ... }: {
  home-manager.users.${settings.username} = {
    programs.bacon = { enable = true; };
  };
}
