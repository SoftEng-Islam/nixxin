{
  settings,
  pkgs,
  ...
}:
{
  programs.vscode.defaultEditor = true;
  programs.vscode = {
    enable = true;
    package = pkgs.update.vscode;
  };
}
