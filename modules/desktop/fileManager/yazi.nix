{
  settings,
  pkgs,
  ...
}:
{
  home-manager.users.${settings.user.username} = {
    programs.yazi = {
      enable = true;
      flavors = {
        inherit (pkgs.yaziFlavors)
          vscode-dark-modern
          vscode-light-modern
          ;
      };
      theme.flavor = {
        use = "vscode-dark-modern";
      };
    };
  };
}
