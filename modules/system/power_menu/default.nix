{ settings, pkgs, ... }: {
  environment.systemPackages = with pkgs; [ ./wlogout.nix ];
}
