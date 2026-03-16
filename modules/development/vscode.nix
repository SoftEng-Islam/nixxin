{
  settings,
  lib,
  pkgs,
  ...
}:
{
  programs.vscode = {
    enable = true;
  };
  home-manager.users.${settings.user.username} = {
    xdg.mimeApps.associations.removed = {
      "inode/directory" = "code.desktop";
    };
  };
}
