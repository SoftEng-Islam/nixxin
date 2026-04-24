# https://nixos.wiki/wiki/AMD_GPU
{ settings, lib, pkgs, ... }:
lib.mkIf (settings.modules.system.rocm.enable or false) {
  boot.kernelModules = [
    "amdgpu.sg_display=0" # Fixes display-related ROCm issues
  ];
  hardware.graphics = {
    extraPackages = with pkgs; [
      # ---- Unlocks OpenCL GPU Acceleration ---- #
      rocmPackages.rocm-runtime
      rocmPackages.rocm-smi
      rocmPackages.rocminfo

      # OpenCL ICD definition for AMD GPUs using the ROCm stack
      rocmPackages.clr.icd

      # OpenCL runtime for AMD GPUs, part of the ROCm stack
      rocmPackages.clr
    ];
  };

  # ---- Rocm Combined ---- #
  # - Fix for AMDGPU - Disabled cause it fails to build as of 30/01/2025
  systemd.tmpfiles.rules = let
    rocmEnv = pkgs.symlinkJoin {
      name = "rocm-combined";
      paths = with pkgs.rocmPackages; [ rocblas hipblas clr ];
    };
  in [
    "L+    /opt/rocm   -    -    -     -    ${rocmEnv}"
    "f /dev/shm/looking-glass 0660 ${settings.user.username} kvm -"
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];

  # ------------------------------------------------
  # ---- etc
  # ------------------------------------------------
  # environment.etc."OpenCL/vendors/amdocl64.icd".source = pkgs.rocmPackages.clr.icd;
  environment.etc."OpenCL/vendors/amdocl64.icd".text =
    "${pkgs.rocmPackages.clr.icd}/lib/libamdocl64.so ";

  # ------------------------------------------------
  # ---- Variables
  # ------------------------------------------------
  environment.variables = {
    ROCM_PATH = "${pkgs.rocmPackages.rocm-runtime}";
    # OCL_ICD_VENDORS = "/etc/OpenCL/vendors/";

    # ROCM_PATH = "${pkgs.rocmPackages.rocm-runtime}";
    # ROCM_TARGET = "gfx700";
    # ROC_ENABLE_PRE_VEGA = "1";

    ROC_ENABLE_PRE_VEGA = "1";

    # HIP_PATH = "${pkgs.rocmPackages.hip-common}/libexec/hip";
    # HSA_OVERRIDE_GFX_VERSION = "9.0.0"; # 10.3.0 or 9.0.0

    # OCL_ICD_VENDORS = "${pkgs.rocmPackages.clr.icd}/etc/OpenCL/vendors/";
  };

  environment.systemPackages = with pkgs; [
    # ------------------------------------------------
    # ---- ROCM Packages
    # ------------------------------------------------
    rocmPackages.clr
    rocmPackages.hip-common
    rocmPackages.hipblas
    rocmPackages.hipcc
    rocmPackages.hipcub
    rocmPackages.hipfft
    rocmPackages.hipify
    rocmPackages.hiprand
    rocmPackages.rocm-runtime
    rocmPackages.rocminfo
    rocmPackages.rpp-opencl

    # ROCm Application for Reporting System Info
    rocmPackages.rocminfo

    # System management interface for AMD GPUs supported by ROCm
    rocmPackages.rocm-smi

    # Platform runtime for ROCm
    rocmPackages.rocm-runtime

    # CMake modules for common build tasks for the ROCm stack
    rocmPackages.rocm-cmake

    # Radeon open compute thunk interface
    rocmPackages.rocm-thunk

    # You should also install the clinfo package to verify that OpenCL is correctly setup (or check in the program you use to see if it is now available, such as in Darktable).
    clinfo
  ];
}
