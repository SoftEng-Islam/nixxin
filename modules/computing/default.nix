{ settings, inputs, config, lib, pkgs, ... }:
let inherit (lib) optionals mkIf;
in {
  # "pocl" OR "opencl"
  imports = optionals (settings.modules.computing.enable) [
    (./. + "/${settings.modules.computing.default}.nix")
    ./clvk.nix
  ];

  config = mkIf (settings.modules.computing.enable) {
    environment.systemPackages = with pkgs; [
      # Portable abstraction of hierarchical architectures for high-performance computing
      (hwloc.override { x11Support = true; })
      ocl-icd
      pocl
    ];
  };
}
