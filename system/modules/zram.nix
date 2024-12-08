{ pkgs, ... }: {
  # zramctl
  zramSwap = {
    enable = true;
    algorithm = "lz4";
    memoryPercent = 75;
    priority = 5;
  };
  environment.systemPackages = with pkgs;
    [
      zram-generator # Systemd unit generator for zram devices
    ];
}
