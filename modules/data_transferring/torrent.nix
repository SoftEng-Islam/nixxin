{ settings, lib, ... }:
let
  transmissionEnabled = settings.modules.data_transferring.transmission.enable or false;
in
{
  #
  # Avahi mDNS
  #

  # avahi-daemon is a service that implements the mDNS/DNS-SD protocol, allowing devices to discover each other on a local network without needing a central DNS server.
  # It is commonly used for service discovery in local networks, such as finding printers, file shares, and other devices.
  # avahi-daemon is often used in conjunction with NetworkManager or systemd-networkd to provide mDNS support.
  # It allows devices to advertise their services and discover services offered by other devices on the same local network.
  # avahi-daemon is typically used in home networks or small office networks where devices need to communicate with each other without manual configuration
  # or a central DNS server.
  services.avahi = {
    enable = false;
    nssmdns4 = true;
    publish = {
      enable = true;
      userServices = true;
      addresses = true;
      workstation = true;
    };
  };

  #
  # Transmission
  #
  services.transmission = lib.mkIf transmissionEnabled {
    enable = true;
    settings = {
      rpc-port = 9091;
      rpc-bind-address = "127.0.0.1";
      rpc-whitelist-enabled = true;
    };
    openPeerPorts = true;
    openRPCPort = false;
  };

  #
  # Sonarr
  #
  services.sonarr = {
    enable = false;
    openFirewall = true;
  };

  # services.jackett = {
  #   enable = true;
  #   openFirewall = true;
  # };

  virtualisation.oci-containers.containers.flaresolverr = {
    image = "ghcr.io/flaresolverr/flaresolverr:v3.2.1";
    autoStart = true;
    ports = [ "127.0.0.1:8191:8191" ];
    extraOptions = [ "--name=flaresolverr" ];
  };
}
