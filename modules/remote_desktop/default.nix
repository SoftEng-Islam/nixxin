{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.remote_desktop.enable) { imports = [ ./rdp.nix ]; }
