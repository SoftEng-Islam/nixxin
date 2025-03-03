{ ... }: {
  imports = [ ./networking.nix ./dnsmasq.nix ];
  services.avahi.enable = true;
  services.avahi.publish.enable = true;
  services.avahi.publish.userServices = true;
}
