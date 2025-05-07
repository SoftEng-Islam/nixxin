{ ... }: {
  imports = [ ./networking.nix ./dnsmasq.nix ./wifi_driver.nix ];
  services.avahi.enable = true;
  services.avahi.publish.enable = true;
  services.avahi.publish.userServices = true;
}
