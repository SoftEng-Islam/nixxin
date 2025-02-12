{ settings, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  _emails = [
    (lib.optional settings.modules.emails.client.enable ./client)
    (lib.optional settings.modules.emails.handlers.enable ./handlers)
  ];
in mkIf (settings.modules.emails.enable) { imports = lib.flatten _emails; }
