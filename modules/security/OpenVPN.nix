{ settings, lib, pkgs, ... }: {
  services.openvpn.servers = {
    # Unless `autoStart = false;', all entries here start automatically as a
    # systemd service. To stop the `home' OpenVPN client service, run `sudo
    # systemctl stop openvpn-home'.
    home = {
      autoStart = true;
      updateResolvConf = true;
      config = builtins.readFile ./home.ovpn;
    };
  };
  environment.systemPackages = with pkgs; [
    openvpn # Robust and highly flexible tunneling application
    networkmanager-openvpn
  ];
}
