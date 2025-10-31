{ settings, lib, pkgs, ... }:
let vpn = settings.modules.vpn;
in {
  # WireGuard is a modern VPN (Virtual Private Network) protocol and software designed to create secure point-to-point connections
  # between devices over the internet.
  # It’s known for being simple, fast, and very secure compared to older VPN protocols like OpenVPN or IPSec.

  # Enable Wireguard
  networking.wireguard.enable = false;

  # sudo mkdir -p /etc/wireguard
  # echo "TheKey=" | sudo tee /etc/wireguard/wg0.key
  # sudo chmod 600 /etc/wireguard/wg0.key

  # To get DNS:
  # resolvectl dns
  # resolvectl status

  # environment.etc."wireguard/wg0.conf".source = ./wg-NL-FREE-219.conf;

  networking.wireguard.interfaces = {
    wg0 = {
      # The IP address of your client inside the tunnel
      ips = [ "10.2.0.2/32" ];

      # Private key (make sure to use NixOS secrets instead of committing this!)
      # privateKey = "TheKey=";
      privateKeyFile = "/etc/wireguard/wg0.key"; # put your private key here

      peers = [{
        publicKey = "x3+j+hjTA71JZ1tfdU60tg+T0btT9ixH5yk2yE7EAXU=";
        allowedIPs = [ "0.0.0.0/0" "::/0" ];
        endpoint = "185.132.132.26:51820";
        persistentKeepalive = 25; # recommended for NAT traversal
      }];
    };
  };
  environment.systemPackages = with pkgs; [ wireguard-ui wireguard-tools ];
}
