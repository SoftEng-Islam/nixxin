{ ... }: {
  imports = [
    ./networking.nix
    ./dnsmasq.nix
    # ./rtw.nix
    ./RTL8188EUS.nix
    ./rtl8188eus-aircrack.nix
  ];
  services.avahi.enable = true;
  services.avahi.publish.enable = true;
  services.avahi.publish.userServices = true;
}
