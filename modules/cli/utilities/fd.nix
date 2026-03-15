{ settings, pkgs, ... }: {
  home-manager.users.${settings.user.username} = {
    programs.fd = { enable = true; };
  };
}
