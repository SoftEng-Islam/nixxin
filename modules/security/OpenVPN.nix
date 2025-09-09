{ settings, lib, pkgs, ... }: {
  services.openvpn.servers.protonvpn = {
    # Unless `autoStart = false;', all entries here start automatically as a
    # systemd service. To stop the `home' OpenVPN client service, run `sudo
    # systemctl stop openvpn-home'.
    home = { config = builtins.readFile ./home.ovpn; };
    autoStart = true;
  };
  environment.systemPackages = with pkgs; [
    openvpn # Robust and highly flexible tunneling application
    networkmanager-openvpn
  ];
}
