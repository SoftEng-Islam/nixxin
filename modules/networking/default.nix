{ ... }: {
  imports = [ ./networking.nix ./dnsmasq.nix ./RTL8188EUS.nix ];
  services.avahi.enable = true;
  services.avahi.publish.enable = true;
  services.avahi.publish.userServices = true;
}
