{ settings, pkgs, ... }: {
  home-manager.users.${settings.username} = {
    programs.helix = { enable = true; };
  };
}
