{ settings, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  _emails = [
    (lib.optional settings.modules.applications.emails.client.enable ./client)
    (lib.optional settings.modules.applications.emails.handlers.enable
      ./handlers)
  ];
in mkIf (settings.modules.applications.emails.enable) {
  imports = lib.flatten _emails;
}
