{
  settings,
  pkgs,
  ...
}:
{
  programs.yazi = {
    enable = true;
    flavors = {
      inherit (pkgs.yaziFlavors)
        vscode-dark-modern
        vscode-light-modern
        ;
    };
    theme.flavor = {
      dark = "vscode-dark-modern";
      light = "vscode-light-modern";
    };
  };
}
