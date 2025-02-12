{ settings, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  _client = [
    (lib.optional settings.modules.applications.emails.client.thunderbird.enable
      ./thunderbird.nix)
    (lib.optional settings.modules.applications.emails.client.geary.enable
      ./geary.nix)
  ];
in mkIf (settings.modules.applications.emails.client.enable) {
  imports = lib.flatten _client;
}
