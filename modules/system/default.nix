# ---- docs.nix ---- #
{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in {

  imports = [ ./dconf.nix ./os.nix ./zram.nix ];

}
