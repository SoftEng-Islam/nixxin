{ settings, pkgs, ... }: {
  home-manager.users.${settings.username} = {
    programs.dircolors = { enable = true; };
  };
}
