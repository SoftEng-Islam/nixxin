{ settings, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  _imports = [
    (lib.optional settings.modules.emails.client.enable ./client)
    (lib.optional settings.modules.emails.handlers.enable ./handlers)
  ];
in { imports = lib.flatten _imports; }
