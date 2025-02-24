{ settings, pkgs, ... }: {
  imports = [ ./beesd.nix ];
  services.fstrim.enable = settings.modules.storage.fstrim.enable;
  environment.systemPackages = with pkgs;
    [
      gparted # Graphical disk partitioning tool
    ];

}
