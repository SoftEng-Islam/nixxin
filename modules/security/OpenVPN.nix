{ settings, lib, pkgs, ... }: {
  services.openvpn.servers.protonvpn = {
    config = ''
      config /etc/openvpn/protonvpn.ovpn
    '';
    autoStart = true;
  };
  environment.systemPackages = with pkgs; [
    openvpn # Robust and highly flexible tunneling application
    networkmanager-openvpn
  ];
}
