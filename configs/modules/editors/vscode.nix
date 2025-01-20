{ settings, pkgs, ... }: {
  home-manager.users.${settings.username} = {
    programs.vscode = {
      enable = true;
      extensions = [ ];
    };
  };
}
