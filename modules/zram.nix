{ settings, pkgs, ... }: {
  # zramctl
  zramSwap = {
    enable = settings.system.features.zram.enable;
    algorithm = settings.system.features.zram.algorithm; # lz4 or zstd
    memoryPercent = 50;
    swapDevices = 1;
    priority = 100;
  };
  environment.systemPackages = with pkgs; [
    lz4 # Extremely fast compression algorithm
    zstd # Zstandard real-time compression algorithm
    zram-generator # Systemd unit generator for zram devices
  ];
}
