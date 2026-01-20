{ settings, lib, inputs, pkgs, ... }:
let
  system = pkgs.stdenv.hostPlatform.system;
  nixos-opencl = inputs.nixos-opencl;
in lib.mkIf (settings.modules.graphics.nixos-opencl or false) {
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
    # OCL_ICD_VENDORS = "${mesa.opencl}/etc/OpenCL/vendors/";
    # OCL_ICD_VENDORS = "${nixos-opencl.packages.${system}.clvk}/etc/OpenCL/vendors/";

    # This is the default for Mesa, but we set it explicitly to ensure
    OCL_ICD_VENDORS = "${pkgs.symlinkJoin {
      name = "opencl-vendors";
      paths = [
        "${nixos-opencl.packages.${system}.mesa}/etc/OpenCL/vendors"
        "${nixos-opencl.packages.${system}.clvk}/etc/OpenCL/vendors"
        "${nixos-opencl.packages.${system}.pocl}/etc/OpenCL/vendors"
      ];
    }}";

  };
}
