{ settings, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  _client = [
    (lib.optional settings.modules.emails.client.thunderbird.enable
      ./thunderbird.nix)
    (lib.optional settings.modules.emails.client.geary.enable ./geary.nix)
  ];
in mkIf (settings.modules.emails.client.enable) {
  imports = lib.flatten _client;
}
