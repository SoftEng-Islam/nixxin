{ settings, pkgs, ... }: {
  home-manager.users.${settings.username} = {
    programs.emacs = { enable = true; };
  };
}
