{ settings, lib, pkgs, ... }: {
  services.openvpn.servers.protonvpn = {
    home = {
      config =
        builtins.readFile /home/${settings.user.username}/openvpn/home.ovpn;
    };
    autoStart = true;
  };
  environment.systemPackages = with pkgs; [
    openvpn # Robust and highly flexible tunneling application
    networkmanager-openvpn
  ];
}
