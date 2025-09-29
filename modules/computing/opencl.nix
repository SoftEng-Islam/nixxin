{ settings, lib, pkgs, ... }: {
  hardware.graphics.extraPackages = [
    # NOTE: at some point GPUs in the R600-family and newer
    # may need to replace this with the "rusticl" ICD;
    # and GPUs in the R500-family and older may need to
    # pin the package version or backport/patch this back in
    # - https://www.phoronix.com/news/Mesa-Delete-Clover-Discussion
    # - https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/19385
    pkgs.mesa.opencl
  ];
  environment.variables = {
    # Optional: For Polaris cards (Radeon 500 series) OpenCL support
    ROC_ENABLE_PRE_VEGA = "1";
    # RUSTICL_ENABLE = "radeonsi";
  };
  environment.systemPackages = with pkgs; [
    ocl-icd # OpenCL ICD Loader for opencl-headers-2023.12.14
    openal # OpenAL alternative
    opencl-clang # A clang wrapper library with an OpenCL-oriented API and the ability to compile OpenCL C kernels to SPIR-V modules
    opencl-clhpp # OpenCL Host API C++ bindings
    opencl-headers # Khronos OpenCL headers version 2023.12.14
    clblast # Tuned OpenCL BLAS library
    clinfo # Print all known information about all available OpenCL platforms and devices in the system
    clpeak # Tool which profiles OpenCL devices to find their peak capacities
    khronos-ocl-icd-loader # Official Khronos OpenCL ICD Loader
  ];
}
