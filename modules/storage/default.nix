{ settings, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  _imports =
    [ (lib.optional settings.modules.storage.beesd.enable ./beesd.nix) ];
in mkIf (settings.modules.storage.enable) {
  imports = lib.flatten _imports;
  services.fstrim.enable = settings.modules.storage.fstrim.enable;
  environment.systemPackages = with pkgs;
    [
      gparted # Graphical disk partitioning tool
    ];

}
