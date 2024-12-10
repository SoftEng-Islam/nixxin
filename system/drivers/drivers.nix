{ pkgs, ... }: {
  # Here you will find the hardware and drviers configurations
  hardware = {
    amdgpu.amdvlk.enable = true;
    amdgpu.amdvlk.support32Bit.enable = true;
    amdgpu.amdvlk.supportExperimental.enable = true;
    amdgpu.initrd.enable = false;
    amdgpu.opencl.enable = true;
    amdgpu.legacySupport.enable = true;
    cpu.amd.updateMicrocode = true;
    enableAllFirmware = true;
    graphics.enable = true;
    graphics.enable32Bit = true;
    amdgpu.amdvlk.settings = {
      AllowVkPipelineCachingToDisk = 1;
      EnableVmAlwaysValid = 1;
      IFH = 0;
      IdleAfterSubmitGpuMask = 1;
      ShaderCacheMode = 1;
    };

    graphics.extraPackages = with pkgs; [
      rocmPackages.clr.icd
      mesa.opencl
      amdvlk
      driversi686Linux.amdvlk
    ];
  };
  systemd.tmpfiles.rules =
    [ "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}" ];
  environment = {
    variables = {
      # For AMD GPUs
      GPU_MAX_ALLOC_PERCENT = "50";
      GPU_MAX_HEAP_SIZE = "50";
      GPU_SINGLE_ALLOC_PERCENT = "50";
      GPU_MAX_USE_SYNC_OBJECTS = "1";
      GPU_FORCE_64BIT_PTR = "1";
      # As of ROCm 4.5, AMD has disabled OpenCL on Polaris based cards. This can be re-enabled by:
      ROC_ENABLE_PRE_VEGA = "1";
      AMD_VULKAN_ICD = "RADV";
    };
    systemPackages = with pkgs; [
      oclgrind # OpenCL device simulator and debugger
      amd-ucodegen # Tool to generate AMD microcode files
      microcode-amd # AMD Processor microcode patch
      pciutils # Collection of programs for inspecting and manipulating configuration of PCI devices
      linux-firmware # Binary firmware collection packaged by kernel.org
      # AMD Stuff
      amdvlk # AMD Open Source Driver For Vulkan
      driversi686Linux.amdvlk # AMD Open Source Driver For Vulkan
      driversi686Linux.mesa # An open source 3D graphics library
      amdenc # AMD Encode Core Library
      amdctl # Set P-State voltages and clock speeds on recent AMD CPUs on Linux
      amd-blis # BLAS-compatible library optimized for AMD CPUs
      amd-libflame # LAPACK-compatible linear algebra library optimized for AMD CPUs
      amf # AMD's closed source Advanced Media Framework (AMF) driver
      aocl-utils # Interface to all AMD AOCL libraries to access CPU features

      clinfo # Print all known information about all available OpenCL platforms and devices in the system
      dxvk # A Vulkan-based translation layer for Direct3D
      glaxnimate # Simple vector animation program.
      glmark2 # OpenGL (ES) 2.0 benchmark
      gpu-viewer # A front-end to glxinfo, vulkaninfo, clinfo and es2_info
      hwdata # Hardware Database, including Monitors, pci.ids, usb.ids, and video cards
      khronos-ocl-icd-loader # Official Khronos OpenCL ICD Loader
      libdrm # Direct Rendering Manager library and headers
      libplacebo # Reusable library for GPU-accelerated video/image rendering primitives
      libva # An implementation for VA-API (Video Acceleration API)
      libva-utils # A collection of utilities and examples for VA-API
      mesa
      mesa # An open source 3D graphics library
      mesa_glu
      mesa_i686
      mesa-demos # Collection of demos and test programs for OpenGL and Mesa
      ocl-icd # OpenCL ICD Loader for opencl-headers-2023.12.14
      openal # OpenAL alternative
      opencl-clang # A clang wrapper library with an OpenCL-oriented API and the ability to compile OpenCL C kernels to SPIR-V modules
      opencl-clhpp # OpenCL Host API C++ bindings
      opencl-headers # Khronos OpenCL headers version 2023.12.14
      oclgrind # OpenCL device simulator and debugger

      rocmPackages.rocm-core
      rocmPackages.rocm-comgr
      rocmPackages.rocm-runtime
      rocmPackages.rocm-smi
      rocmPackages.rocminfo
      rocmPackages.rocm-cmake
      rocmPackages.rocm-thunk # Radeon open compute thunk interface
      rocmPackages.rocm-device-libs # Set of AMD-specific device-side language runtime libraries
      rocmPackages.hip-common
      rocmPackages.hipify
      rocmPackages.half
      rocmPackages.hipcc
      rocmPackages.hiprand
      rocmPackages.hipsolver
      rocmPackages.hsa-amd-aqlprofile-bin # AQLPROFILE library for AMD HSA runtime API extension support
      clpeak # Tool which profiles OpenCL devices to find their peak capacities

      vkbasalt # Vulkan post processing layer for Linux
      vkquake # Vulkan Quake port based on QuakeSpasm
      vulkan-extension-layer # Layers providing Vulkan features when native support is unavailable
      vulkan-headers # Vulkan Header files and API registry
      vulkan-tools # Khronos official Vulkan Tools and Utilities
      vulkan-utility-libraries # Set of utility libraries for Vulkan

      xorg.xf86videoamdgpu

      # apps
      lact # Linux AMDGPU Controller

    ];
  };
}
