{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.overclock.enable) {
  imports = [ ./corectrl.nix ./lactd.nix ];

}
