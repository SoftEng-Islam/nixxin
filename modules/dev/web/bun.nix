{ settings, pkgs, ... }: {
  environment.variables = { BUN_INSTALL = "$HOME/.bun"; };
  home-manager.users.${settings.users.selected.username} = {
    programs.bun = { enable = true; };
  };
}
