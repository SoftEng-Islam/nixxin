{ settings, lib, pkgs, ... }: {
  # Enable Wireguard
  networking.wireguard.enable = true;

  # environment.etc."wireguard/wg0.conf".source = ./wg-NL-FREE-219.conf;

  networking.wireguard.interfaces = {
    wg0 = {
      # The IP address of your client inside the tunnel
      ips = [ "10.2.0.2/32" ];

      # Private key (make sure to use NixOS secrets instead of committing this!)
      privateKey = "kHLjKIUiIOdfzWBRjr+oFsX6ac1x7o98hrd7mpiwNGA=";

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
