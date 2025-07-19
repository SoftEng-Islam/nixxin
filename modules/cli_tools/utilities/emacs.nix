{ settings, pkgs, ... }: {
  home-manager.users.${settings.user.username} = {
    programs.emacs = { enable = true; };
  };
}
