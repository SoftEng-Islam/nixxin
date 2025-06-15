{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.zram.enable or true) {
  # Swap Tweaks for Performance
  # Run Command "zramctl"
  zramSwap = {
    enable = true;
    algorithm = settings.modules.zram.algorithm or "lz4"; # lz4 or zstd
    memoryPercent = 30; # Uses 30% of RAM as compressed swap
    swapDevices = 1;
    priority = 100;
  };
  environment.systemPackages = with pkgs; [
    lz4 # Extremely fast compression algorithm
    # zstd # Zstandard real-time compression algorithm
    zram-generator # Systemd unit generator for zram devices
  ];
}
