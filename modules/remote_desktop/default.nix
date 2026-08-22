{
  settings,
  lib,
  ...
}:
{
  imports = lib.optionals (settings.modules.remote_desktop.enable) [
    ./rdp.nix
    ./teamviewer.nix
  ];
}
