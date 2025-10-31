{ settings, lib, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    protonvpn-cli # Linux command-line client for ProtonVPN
    protonvpn-cli_2
    protonvpn-gui
  ];
}
