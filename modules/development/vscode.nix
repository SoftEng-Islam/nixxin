{
  settings,
  lib,
  pkgs,
  ...
}:
{
  programs.vscode = {
    enable = true;
    package = pkgs.update.vscode;
  };
  programs.vscode.defaultEditor = true;
  home-manager.users.${settings.user.username} = {
    xdg.mimeApps.associations.removed = {
      "inode/directory" = "code.desktop";
    };
  };
}
