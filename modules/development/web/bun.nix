{ settings, pkgs, ... }: {
  environment.variables = { BUN_INSTALL = "$HOME/.bun"; };
  home-manager.users.${settings.user.username} = {
    programs.bun = { enable = true; };
  };
}
