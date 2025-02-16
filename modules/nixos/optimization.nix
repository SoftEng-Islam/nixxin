{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.nixos.optimization.enable) {
  services.scx = {
    enable = true;
    scheduler = "scx_rusty";
    package = pkgs.scx.rustscheds;
  };
}
