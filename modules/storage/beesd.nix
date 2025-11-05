{ settings, pkgs, ... }: {
  # What is Bees (or beesd)?
  # Bees is a deduplication tool specifically designed for Btrfs (a Linux file system with advanced features).
  # It identifies duplicate data blocks in a Btrfs file system and reduces disk usage by storing only a single copy of the data.
  # Deduplication: Bees scans the filesystem for identical data blocks and replaces duplicate copies with references to the same data block.
  # Efficient for Large Filesystems: It uses a hashtable to manage deduplication efficiently without using excessive memory or CPU resources.
  # The beesd service is the system daemon that runs Bees.
  services.beesd = {
    enable =
      settings.modules.storage.beesd.enable or false; # Enable the Bees service.
    filesystems.btrfs = {
      # Specify the Btrfs filesystem to deduplicate.
      spec = "/mnt/btrfs";

      # Optional: Directory for Bees to store metadata and temporary files.
      # Default: A subdirectory on the target filesystem.
      workDir = "/mnt/btrfs/bees-workdir";

      # Set verbosity level for logs (optional).
      verbosity = 2;

      # Set the size of the hash table in MB (e.g., 1GB).
      hashTableSizeMB = 1024;

      # Add extra options for Bees (optional).
      extraOptions = "--max-hops 2";
    };
  };
}
