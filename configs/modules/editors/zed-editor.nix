{ settings, pkgs, ... }: {
  home-manager.users.${settings.username} = {
    programs.zed-editor = { enable = true; };
  };
}
