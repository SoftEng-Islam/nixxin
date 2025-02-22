{ ... }: {
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/ba8daecb-c5d6-4dc9-bc51-a38b344ca6ed";
    fsType = "btrfs";
    options = [ "subvol=@" ];
  };
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/7FD3-5156";
    fsType = "vfat";
    # options = [ "fmask=0077" "dmask=0077" ];
    options = [ "rw" ];
  };
  fileSystems."/data" = {
    device = "/dev/disk/by-uuid/67F7388D1080E3AB";
    fsType = "ntfs-3g";
    options = [
      "rw"
      "nofail"
      "nodev"
      "uid=1000"
      "gid=1000"
      "utf8"
      "umask=022"
      "exec"
      "x-gvfs-show"
    ];
  };
}
