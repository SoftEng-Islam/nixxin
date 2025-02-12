{ settings, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  _client = [
    (lib.optional settings.modules.apps.emails.client.thunderbird.enable
      ./thunderbird.nix)
    (lib.optional settings.modules.apps.emails.client.geary.enable ./geary.nix)
  ];
in mkIf (settings.modules.apps.emails.client.enable) {
  imports = lib.flatten _client;
}
