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

  # services.lvm.enable = true;
  # If lvm is enabled, then tell it to issue discard. This is
  # good for SSDs and has almost no downsides on HDDs, so
  # it's a good idea to enable it unconditionally.
  # environment.etc."lvm/lvm.conf".text = ''
  #   devices {
  #     issue_discards = 1
  #   }
  # '';

  # Discard blocks that are not in use by the filesystem, should be
  # generally good for SSDs. This service is enabled by default, but
  # I am yet to test the performance impact on a system with no SSDs.
  services.fstrim = {
    # We may enable this unconditionally across all systems because it's performance
    # impact is negligible on systems without a SSD - which means it's a no-op with
    # almost no downsides aside from the service firing once per week.
    enable = settings.modules.storage.fstrim.enable;

    # The timer interval passed to the systemd service. The default is monthly
    # but we prefer trimming weekly as the system receives a lot of writes.
    interval = "weekly";
  };

  environment.systemPackages = with pkgs; [
    gparted # Graphical disk partitioning tool
    gnome-disk-utility
  ];
}
