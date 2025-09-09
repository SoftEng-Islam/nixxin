{ settings, lib, pkgs, ... }: {
  # See `man openvpn' and `man 5 openvpn' for details on the options below.
  # To debug connection issues, check the status of the OpenVPN service with
  # `sudo systemctl status openvpn-<name>', where `<name>' is the name of the
  # entry below (e.g. `home' for the example below). For example:
  # sudo systemctl status openvpn-home
  # sudo journalctl -u openvpn-home -e | tail -n 50

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
  environment.etc."openvpn/home.auth".source = ./home.auth;

  environment.systemPackages = with pkgs; [
    openvpn # Robust and highly flexible tunneling application
    networkmanager-openvpn
  ];
}
