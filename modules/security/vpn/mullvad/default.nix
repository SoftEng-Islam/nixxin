{ settings, lib, pkgs, ... }: {
  environment.systemPackages = with pkgs; [ mullvad-vpn ];
}
