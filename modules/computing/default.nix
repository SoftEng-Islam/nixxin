{ settings, inputs, config, lib, pkgs, ... }:
let inherit (lib) optionals mkIf;
in mkIf (settings.modules.computing.enable) {
  hardware.graphics.extraPackages = with pkgs;
    [
      # NOTE: at some point GPUs in the R600-family and newer
      # may need to replace this with the "rusticl" ICD;
      # and GPUs in the R500-family and older may need to
      # pin the package version or backport/patch this back in
      # - https://www.phoronix.com/news/Mesa-Delete-Clover-Discussion
      # - https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/19385
      mesa.opencl
      # ocl-icd
      # pocl
    ];
  environment.variables = {
    # Optional: For Polaris cards (Radeon 500 series) OpenCL support
    ROC_ENABLE_PRE_VEGA = "1";
    RUSTICL_ENABLE = "radeonsi";
  };
  environment.systemPackages = with pkgs; [
    # ocl-icd # OpenCL ICD Loader for opencl-headers-2023.12.14
    openal # OpenAL alternative
    # intel-graphics-compiler
    # opencl-clhpp # OpenCL Host API C++ bindings
    opencl-headers # Khronos OpenCL headers version 2023.12.14
    clinfo # Print all known information about all available OpenCL platforms and devices in the system
    clpeak # Tool which profiles OpenCL devices to find their peak capacities
    khronos-ocl-icd-loader # Official Khronos OpenCL ICD Loader
    # Portable abstraction of hierarchical architectures for high-performance computing
    (hwloc.override { x11Support = true; })
  ];
}
