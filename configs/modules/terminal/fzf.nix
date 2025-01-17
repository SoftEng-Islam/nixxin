{ settings, pkgs, ... }: {
  home-manager.users.${settings.username} = {
    programs.fzf = { enable = true; };
  };
}
