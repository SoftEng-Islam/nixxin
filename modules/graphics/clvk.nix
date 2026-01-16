{ settings, inputs, pkgs, lib, ... }: {
  nixpkgs.overlays = [ inputs.opencl-flake.overlays.default ];
  environment.systemPackages = with pkgs; [
    khronos-ocl-icd-loader
    clvk
    pocl
    clinfo
  ];
}
