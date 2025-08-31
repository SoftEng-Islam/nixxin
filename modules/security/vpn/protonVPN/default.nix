{ settings, lib, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    protonvpn
    protonvpn-cli
    protonvpn-cli_2
    protonvpn-gui
  ];
}
