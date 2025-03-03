{ settings, pkgs, ... }: {
  services.dnsmasq = {
    # Configure dnsmasq
    enable = if (settings.modules.networking.dnsResolver == "dnsmasq") then
      true
    else
      false;
    alwaysKeepRunning = true;
    settings = {
      # port = 9751;
      # Set Google DNS for IPv4 and IPv6
      server = settings.modules.networking.nameservers;
      # interface = "waydroid0";
      # bind-interfaces = true;
      # Provide DHCP settings (if applicable)
      dhcp-range = "10.42.0.10,10.42.0.100,12h"; # Adjust to your network
    };
  };
  systemd.services.dnsmasq = {
    restartIfChanged = false; # Prevent unnecessary restarts during rebuild.
    serviceConfig = {
      # Restart =  "on-failure"; # Restart only on failure"
      # RestartSec = "5s"; # Add a 5-second delay before restarting.
    };
  };
  environment.systemPackages = with pkgs;
    [
      dnsmasq # An integrated DNS, DHCP and TFTP server for small networks
    ];
}
