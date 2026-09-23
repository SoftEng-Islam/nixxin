{
  settings,
  lib,
  ...
}:
{
  imports = lib.optionals (settings.modules.remote_desktop.enable or false) [
    ./rdp.nix
    ./teamviewer.nix
  ];
}
