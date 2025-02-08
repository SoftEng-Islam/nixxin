{ settings, pkgs, ... }: {
  services.dnsmasq = {
    # Configure dnsmasq
    enable =
      if (settings.networks.dnsResolver == "dnsmasq") then true else false;
    alwaysKeepRunning = true;
    settings = {
      # Set Google DNS for IPv4 and IPv6
      server = settings.networks.nameservers;
      #interface = "lo,waydroid0";
      #bind-interfaces = true;
      # Provide DHCP settings (if applicable)
      dhcp-range = "10.42.0.10,10.42.0.100,12h"; # Adjust to your network
    };
  };
  systemd.services.dnsmasq = {
    restartIfChanged = false; # Prevent unnecessary restarts during rebuild.
    serviceConfig = {
      Restart = "always";
      RestartSec = "5s"; # Add a 5-second delay before restarting.
    };
  };
  environment.systemPackages = with pkgs;
    [
      dnsmasq # An integrated DNS, DHCP and TFTP server for small networks
    ];
}
