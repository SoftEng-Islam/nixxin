{ settings, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  _emails = [
    (lib.optional settings.modules.apps.emails.client.enable ./client)
    (lib.optional settings.modules.apps.emails.handlers.enable ./handlers)
  ];
in mkIf (settings.modules.apps.emails.enable) { imports = lib.flatten _emails; }
