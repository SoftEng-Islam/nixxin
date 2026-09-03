# https://nixos.wiki/wiki/AMD_GPU
{
  settings,
  lib,
  pkgs-older,
  ...
}:
{
  boot.kernelModules = [
    "amdgpu.sg_display=0" # Fixes display-related ROCm issues
  ];
  hardware.graphics = {
    extraPackages = with pkgs-older; [
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
  # (rocblas/hipblas symlinkJoin was previously left active despite this
  # comment claiming otherwise, which would break the build if this module is
  # ever enabled — now actually removed. Re-add once rocblas/hipblas build
  # cleanly again for whichever host enables this module.)
  systemd.tmpfiles.rules = [
    "f /dev/shm/looking-glass 0660 ${settings.user.username} kvm -"
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs-older.rocmPackages.clr}"
  ];

  # ------------------------------------------------
  # ---- etc
  # ------------------------------------------------
  # environment.etc."OpenCL/vendors/amdocl64.icd".source = pkgs-older.rocmPackages.clr.icd;
  environment.etc."OpenCL/vendors/amdocl64.icd".text =
    "${pkgs-older.rocmPackages.clr.icd}/lib/libamdocl64.so ";

  # ------------------------------------------------
  # ---- Variables
  # ------------------------------------------------
  environment.variables = {
    ROCM_PATH = "${pkgs-older.rocmPackages.rocm-runtime}";
    # OCL_ICD_VENDORS = "/etc/OpenCL/vendors/";

    # ROCM_PATH = "${pkgs-older.rocmPackages.rocm-runtime}";
    # ROCM_TARGET = "gfx700";
    # ROC_ENABLE_PRE_VEGA = "1";

    ROC_ENABLE_PRE_VEGA = "1";

    # HIP_PATH = "${pkgs-older.rocmPackages.hip-common}/libexec/hip";
    # HSA_OVERRIDE_GFX_VERSION = "9.0.0"; # 10.3.0 or 9.0.0

    # OCL_ICD_VENDORS = "${pkgs-older.rocmPackages.clr.icd}/etc/OpenCL/vendors/";
  };

  environment.systemPackages = with pkgs-older; [
    # ------------------------------------------------
    # ---- ROCM Packages
    # ------------------------------------------------
    rocmPackages.clr
    rocmPackages.hip-common
    rocmPackages.hipblas
    rocmPackages.hipcc
    # rocmPackages.hipcub
    # rocmPackages.hipfft
    # rocmPackages.hipify
    # rocmPackages.hiprand
    rocmPackages.rocm-runtime
    rocmPackages.rocminfo
    rocmPackages.rpp

    # ROCm Application for Reporting System Info
    rocmPackages.rocminfo

    # System management interface for AMD GPUs supported by ROCm
    rocmPackages.rocm-smi

    # Platform runtime for ROCm
    rocmPackages.rocm-runtime

    # You should also install the clinfo package to verify that OpenCL is correctly setup (or check in the program you use to see if it is now available, such as in Darktable).
    clinfo
  ];
}
