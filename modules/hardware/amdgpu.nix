{ settings, lib, pkgs, ... }: {
  environment.variables = { };
  services = {
    xserver.videoDrivers = [ "amdgpu" "radeon" ];

    # Whether to enable auto-epp for amd active pstate.
    auto-epp.enable = true;
  };
  hardware = {
    cpu.amd.updateMicrocode = true;
    # cpu.amd.sev.enable = true;
    enableRedistributableFirmware = true;
    amdgpu.initrd.enable = true;
    amdgpu.amdvlk.enable = true;
    amdgpu.amdvlk.support32Bit.enable = true;
    amdgpu.amdvlk.supportExperimental.enable = true;
    amdgpu.opencl.enable = false;
    amdgpu.legacySupport.enable = false;
    amdgpu.amdvlk.settings = {
      IFH = 0;
      ShaderCacheMode = 1;
      EnableVmAlwaysValid = 1;
      IdleAfterSubmitGpuMask = 1;
      AllowVkPipelineCachingToDisk = 1;
    };
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        amdvlk
        mesa
        mesa.opencl

        libvdpau-va-gl
        libGL
        libGLU
        libGLX
        libva
        libva-utils
        vaapiVdpau
        pocl

        # rocmPackages.clr
        # rocmPackages.clr.icd
        # rocmPackages.rocm-runtime
        # rocmPackages.rocm-smi
        # rocmPackages.rocminfo
      ];
      extraPackages32 = [
        pkgs.driversi686Linux.amdvlk
        #  pkgs.pkgsi686Linux.libva
      ];
    };
  };
  environment.variables = {
    AMD_VULKAN_ICD = "RADV";

    GPU_FORCE_64BIT_PTR = "1";
    GPU_MAX_ALLOC_PERCENT = "50";
    GPU_MAX_HEAP_SIZE = "50";
    GPU_MAX_USE_SYNC_OBJECTS = "1";
    GPU_SINGLE_ALLOC_PERCENT = "50";

    # HIP_PATH = "${pkgs.rocmPackages.hip-common}/libexec/hip";
    HSA_OVERRIDE_GFX_VERSION = "9.0.0"; # 10.3.0 or 9.0.0

    LIBVA_DRIVER_NAME = "amdgpu"; # Load AMD driver for Xorg and Waylandard
    # OCL_ICD_VENDORS = "${pkgs.rocmPackages.clr.icd}/etc/OpenCL/vendors/";
    # OCL_ICD_VENDORS = "/etc/OpenCL/vendors/";

    VDPAU_DRIVER = "amdgpu";
    VK_ICD_FILENAMES = "${pkgs.amdvlk}/share/vulkan/icd.d/amd_icd64.json";
  };
  environment.systemPackages = with pkgs; [

    amd-blis # BLAS-compatible library optimized for AMD CPUs
    amd-ucodegen # Tool to generate AMD microcode files
    amdctl # Set P-State voltages and clock speeds on recent AMD CPUs on Linux
    amdenc # AMD Encode Core Library
    amdgpu_top # Tool to display AMDGPU usage
    amdvlk # AMD Open Source Driver For Vulkan
    aocl-utils # Interface to all AMD AOCL libraries to access CPU features
    driversi686Linux.amdvlk # AMD Open Source Driver For Vulkan
    driversi686Linux.mesa # An open source 3D graphics library
    mesa_glu # OpenGL utility library
    mesa_i686 # Open source 3D graphics library
    microcode-amd # AMD Processor microcode patch
    microcodeAmd # AMD Processor microcode patch
    nvtopPackages.amd # (h)top like task monitor for AMD, Adreno, Intel and NVIDIA GPUs
    xorg.xf86videoamdgpu

    # amd-libflame # LAPACK-compatible linear algebra library optimized for AMD CPUs
    # amf # AMD's closed source Advanced Media Framework (AMF) driver
  ];

  home-manager.users."${settings.user.username}" = { };
}
