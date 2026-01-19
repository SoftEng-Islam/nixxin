{ settings, lib, inputs, pkgs, ... }:
let
  system = pkgs.stdenv.hostPlatform.system;
  nixos-opencl = inputs.nixos-opencl;
in lib.mkIf (settings.modules.graphics.nixos-opencl) {
  environment.systemPackages = with pkgs; [
    clinfo
    opencl-headers
    # nixos-opencl.packages.${system}.clvk
  ];
  hardware.graphics.extraPackages = with pkgs;
    [
      # Official Khronos OpenCL ICD Loader
      (lib.hiPrio khronos-ocl-icd-loader)
    ];
  environment.sessionVariables = {
    OCL_ICD_VENDORS = let
      drivers = [
        nixos-opencl.packages.${system}.mesa
        nixos-opencl.packages.${system}.clvk
        nixos-opencl.packages.${system}.pocl
      ];
    in pkgs.symlinkJoin {
      name = "opencl-vendors";
      paths = drivers;
    };
  };
}
