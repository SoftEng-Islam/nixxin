{ settings, pkgs, ... }: {
  # imports = [ ./beesd.nix ];
  # ------------------------------------------------
  # ---- Storage Configuration
  # ------------------------------------------------
  # Btrfs scrub checks all data and metadata on the disk for corruption.
  # If checksum mismatches are found, Btrfs attempts to repair them using redundant copies (if available).
  # Similar to ZFS scrub but for Btrfs filesystems.
  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
  };

  # TRIM is a command that tells the SSD which blocks are no longer needed (e.g., after file deletions).
  # SSDs cannot overwrite data directly like HDDs—they must erase old data before writing new data.
  # Without TRIM, SSDs can slow down over time due to inefficient block management.
  services.fstrim.enable = settings.modules.storage.fstrim.enable;

  environment.systemPackages = with pkgs; [
    gparted # Graphical disk partitioning tool
    gnome-disk-utility
  ];
}
