{ settings, config, lib, pkgs, ... }:
let inherit (lib) mkIf;
in {
  # "pocl" OR "opencl"
  imports = [ (./. + "/${settings.modules.computing.default}.nix") ];

  config = mkIf (settings.modules.computing.enable) {
    environment.systemPackages = with pkgs;
      [
        # Portable abstraction of hierarchical architectures for high-performance computing
        (hwloc.override { x11Support = true; })
      ];
  };
}
