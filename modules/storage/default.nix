{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;

in mkIf (settings.modules.storage.enable) {
  imports = [ ./beesd.nix ];
  services.fstrim.enable = settings.modules.storage.fstrim.enable;
  environment.systemPackages = with pkgs;
    [
      gparted # Graphical disk partitioning tool
    ];

}
