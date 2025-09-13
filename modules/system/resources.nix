{ settings, lib, pkgs, ... }: {
  environment.systemPackages = with pkgs; [ htop ];
}
