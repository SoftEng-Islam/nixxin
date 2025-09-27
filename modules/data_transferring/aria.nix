{ settings, lib, config, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.data_transferring.aria.enable or true) {
  home-manager.users.${settings.user.username} = {
    home.file.".config/aria2/aria2.conf".text = lib.mkForce ''
      # ===============================
      #  Aria2 Optimized Configuration
      # ===============================

      # -------- General --------
      continue=true                # Resume downloads
      max-concurrent-downloads=5   # How many files to download at once
      summary-interval=5           # Status update every 5s
      console-log-level=warn       # Cleaner output (warn, error, info, debug)

      # -------- Connections --------
      split=16                     # Split each file into 16 segments
      max-connection-per-server=16 # Up to 16 connections per host
      min-split-size=1M            # Allow small chunks to maximize parallelism

      # -------- Timeouts & Retries --------
      timeout=15                   # 15s connection timeout
      max-tries=10                 # Retry up to 10 times
      retry-wait=5                 # Wait 5s between retries
      lowest-speed-limit=50K       # Kill connections slower than 50 KB/s

      # -------- Files --------
      dir=~/Downloads              # Default download directory
      file-allocation=falloc       # Fast allocation (use prealloc if ext3/FAT32)
      max-file-not-found=2         # Fail faster if mirrors are broken

      # -------- BitTorrent --------
      enable-dht=true              # Enable DHT (IPv4)
      enable-dht6=false            # Disable DHT over IPv6 (optional)
      listen-port=6881-6999        # BT listening ports
      max-overall-upload-limit=1M  # Cap total upload (adjust as you like)
      max-upload-limit=50K         # Limit per torrent upload

      # -------- Advanced --------
      check-integrity=true         # Verify file integrity when possible
    '';
  };

  environment.systemPackages = with pkgs; [ aria2 ];
}
