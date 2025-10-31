# ------------------------------------------------
# ---- DNSMASQ
# ------------------------------------------------
# This module configures dnsmasq as a DNS resolver.
# Dnsmasq is a lightweight DNS forwarder and DHCP server.
# It is used to provide DNS services for local networks and can also handle DHCP.
# This configuration is useful for systems that require local DNS resolution or DHCP services.
# It is particularly useful in environments where you want to manage DNS settings locally or provide DHCP services
{ settings, pkgs, ... }:
let _networking = settings.modules.networking;
in {
  services.dnsmasq = {
    # Configure dnsmasq
    enable = if (_networking.dnsResolver == "dnsmasq") then true else false;
    alwaysKeepRunning = true;
    settings = {
      # port = 9751;
      # Set Google DNS for IPv4 and IPv6
      server = _networking.nameservers;
      # interface = "waydroid0";
      # bind-interfaces = true;
      # Provide DHCP settings (if applicable)
      # dhcp-range = "10.42.0.10,10.42.0.100,12h"; # Adjust to your network
    };
  };
  systemd.services.dnsmasq = {
    restartIfChanged = false; # Prevent unnecessary restarts during rebuild.
    serviceConfig = {
      # Restart =  "on-failure"; # Restart only on failure"
      # RestartSec = "5s"; # Add a 5-second delay before restarting.
    };
  };
}
