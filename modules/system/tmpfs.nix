{ settings, config, lib, ... }:
let
  # /var/tmp doesn't seem to be on tmpfs like /tmp (when using zram) but
  # seems to contain near duplicate systemd unit folders?...
  # dir must exist on a new system to avoid error as nixos-rebuild uses
  # mktemp -d and won't implicitly create parents
  nixTmpDir = "/var/tmp";

in {
  #? [boot.tmp.useTmpfs] What it does:
  # Mounts /tmp as a tmpfs — a RAM-backed filesystem.
  # This means files in /tmp are stored in memory, not on your SSD or disk.
  # Very fast read/write (RAM speed)
  # Good for SSD lifespan (fewer writes)
  # Automatically wiped on reboot (volatile — nothing persists).
  boot.tmp.useTmpfs = lib.mkDefault settings.modules.system.boot.tmp.useTmpfs;
  # If not using tmpfs, which is naturally purged on reboot, we must clean it
  # /tmp ourselves. /tmp should be volatile storage!
  boot.tmp.cleanOnBoot = lib.mkDefault (!config.boot.tmp.useTmpfs);
  boot.tmp.tmpfsSize = settings.modules.system.boot.tmp.tmpfsSize;
  # boot.kernelParams = [ "tmpfs.size=2G" ];

  # boot.kernel.sysctl = {
  #   "vm.swappiness" = 180;
  #   "vm.watermark_boost_factor" = 0;
  #   "vm.watermark_scale_factor" = 125;
  #   "vm.page-cluster" = 0;
  # };

  nixpkgs.overlays = [
    # nixos-rebuild ignores tmpdir set (elsewhere in file) to avoid OOS
    # during build when tmp on tmpfs. workaround is this overlay. see:
    # https://github.com/NixOS/nixpkgs/issues/293114#issuecomment-2381582141
    (_final: prev: {
      nixos-rebuild = prev.nixos-rebuild.overrideAttrs (oldAttrs: {
        nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [ prev.makeWrapper ];
        postInstall = oldAttrs.postInstall + ''
          wrapProgram $out/bin/nixos-rebuild --set TMPDIR ${nixTmpDir}
        '';
      });
    })
  ];

  # prevent OOS error during builds when using zram/tmp on tmpfs
  systemd.services.nix-daemon.environment.TMPDIR = nixTmpDir;
  systemd.tmpfiles.rules = [ "d ${nixTmpDir} 0755 root root 1d" ];
  # OOM config (https://discourse.nixos.org/t/nix-build-ate-my-ram/35752)
  systemd.slices."nix-daemon".sliceConfig = {
    ManagedOOMMemoryPressure = "kill";
    ManagedOOMMemoryPressureLimit = "90%";
  };
  systemd.services."nix-daemon".serviceConfig = {
    Slice = "nix-daemon.slice";
    # If kernel OOM does occur, strongly prefer
    # killing nix-daemon child processes
    OOMScoreAdjust = 1000;
  };

  # user-space Out-Of-Memory (OOM) killer.
  # It’s a smarter and more targeted way to deal with low memory situations compared to the traditional kernel OOM killer.
  systemd.oomd = {
    # It will start monitoring system memory pressure and can proactively kill processes when memory is critically low — before the system freezes or hits swap hard.
    enable = settings.modules.system.oom;
    # Use this to prevent system services (like daemons) from bringing down the whole system if memory gets tight.
    enableRootSlice = true;
    # Helps avoid a runaway background service from eating up all memory.
    enableSystemSlice = true;
    # If a user process uses too much RAM, oomd can kill it to protect the rest of the system.
    enableUserSlices = true;
  };
}
