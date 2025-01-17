{ settings, pkgs, ... }: {
  home-manager.users.${settings.username} = {
    programs.feh = { enable = true; };
  };
}
