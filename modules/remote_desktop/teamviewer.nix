{
  settings,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
in
mkIf (settings.modules.remote_desktop.teamviewer.enable or false) {
  environment.systemPackages = with pkgs; [
    teamviewer
  ];
  services.teamviewer = {
    enable = true;
  };
}
