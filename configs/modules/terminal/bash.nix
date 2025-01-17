{ settings, pkgs, ... }: {
  home-manager.users.${settings.username} = {
    programs.bash = { enable = true; };
  };
}
