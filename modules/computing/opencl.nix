{ settings, lib, pkgs, ... }: {
  environment.variables = {
    # Optional: For Polaris cards (Radeon 500 series) OpenCL support
    ROC_ENABLE_PRE_VEGA = "1";
  };
  environment.systemPackages = with pkgs; [
    ocl-icd # OpenCL ICD Loader for opencl-headers-2023.12.14
    oclgrind # OpenCL device simulator and debugger
    openal # OpenAL alternative
    opencl-clang # A clang wrapper library with an OpenCL-oriented API and the ability to compile OpenCL C kernels to SPIR-V modules
    opencl-clhpp # OpenCL Host API C++ bindings
    opencl-headers # Khronos OpenCL headers version 2023.12.14
    clblast # Tuned OpenCL BLAS library

    oclgrind # OpenCL device simulator and debugger
    khronos-ocl-icd-loader # Official Khronos OpenCL ICD Loader
    clinfo # Print all known information about all available OpenCL platforms and devices in the system
    clpeak
  ];
}
