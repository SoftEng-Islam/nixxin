{
  settings,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) optionals optional flatten;
  automations = settings.modules.automation;
  _imports = [
    (optional automations.browser-use.enable ./browser-use.nix)
    (optional automations.n8n.enable ./n8n.nix)
  ];
in
{
  imports = optionals (automations.enable or false) flatten _imports;
  environment.systemPackages = with pkgs; [
    playwright
  ];
}
