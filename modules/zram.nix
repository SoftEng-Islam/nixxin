{ pkgs, ... }: {
  # zramctl
  zramSwap = {
    enable = true;
    algorithm = "zstd"; # lz4 or zstd
    memoryPercent = 50;
    swapDevices = 1;
    priority = 100;
  };
  environment.systemPackages = with pkgs; [
    zstd
    zram-generator # Systemd unit generator for zram devices
  ];
}
