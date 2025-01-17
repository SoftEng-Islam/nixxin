{ settings, pkgs, ... }: {
  home-manager.users.${settings.username} = {
    programs.go = { enable = true; };
  };
}
