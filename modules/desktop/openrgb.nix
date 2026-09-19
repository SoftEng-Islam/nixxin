{ pkgs, ... }: {
  services.hardware.openrgb.enable = true;
  services.hardware.openrgb.motherboard = "amd";
  environment.systemPackages = with pkgs; [
    openrgb
  ];
}
