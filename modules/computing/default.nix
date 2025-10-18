{ settings, inputs, config, lib, pkgs, ... }:
let inherit (lib) optionals mkIf;
in {
  # "pocl" OR "opencl"
  imports = optionals (settings.modules.computing.enable)
    [ (./. + "/${settings.modules.computing.default}.nix") ];

  config = mkIf (settings.modules.computing.enable) {
    environment.systemPackages = with pkgs; [
      inputs.nixos-opencl.packages.${system}.clvk
      # Portable abstraction of hierarchical architectures for high-performance computing
      (hwloc.override { x11Support = true; })
      ocl-icd
      pocl
    ];
  };
}
