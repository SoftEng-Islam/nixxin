{ settings, config, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf {
  imports =
    lib.optionals (settings.modules.remote_desktop.enable) [ ./rdp.nix ];
}
