{
  settings,
  lib,
  pkgs,
  ...
}:
{
  programs.vscode.defaultEditor = true;
  home-manager.users.${settings.user.username} = {
    programs.vscode = {
      enable = true;
      package = pkgs.update.vscode;
      mutableExtensionsDir = true;
    };
    xdg.mimeApps.associations.removed = {
      "inode/directory" = "code.desktop";
    };
  };
}
