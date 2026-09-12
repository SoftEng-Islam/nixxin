# https://nixos.wiki/wiki/AMD_GPU
{
  settings,
  lib,
  pkgs,
  ...
}:
lib.mkIf (settings.modules.system.rocm or false) {
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
  # (rocblas/hipblas symlinkJoin was previously left active despite this
  # comment claiming otherwise, which would break the build if this module is
  # ever enabled — now actually removed. Re-add once rocblas/hipblas build
  # cleanly again for whichever host enables this module.)
  # Map /opt/rocm for applications with hardcoded paths
  systemd.tmpfiles.rules =
    let
      rocmEnv = pkgs.symlinkJoin {
        name = "rocm-combined";
        paths = with pkgs.rocmPackages; [
          clr
          clr.icd
          rocblas
          hipblas
        ];
      };
    in
    [
      "L+ /opt/rocm - - - - ${rocmEnv}"
      "f /dev/shm/looking-glass 0660 ${settings.user.username} kvm -"
      "L+ /opt/rocm/hip - - - - ${pkgs.rocmPackages.clr}"
    ];

  fileSystems."/opt" = {
    device = "tmpfs";
    fsType = "tmpfs";
    options = [ "mode=0755" ];
  };

  # ------------------------------------------------
  # ---- Variables
  # ------------------------------------------------
  environment.variables = {
    ROCM_PATH = "/opt/rocm";
    HIP_PATH = "/opt/rocm";
    HSA_OVERRIDE_GFX_VERSION = "9.0.0";
    ROC_ENABLE_PRE_VEGA = "1";
  };

  environment.systemPackages = with pkgs; [
    # ------------------------------------------------
    # ---- ROCM Packages
    # ------------------------------------------------
    rocmPackages.clr
    rocmPackages.hip-common
    rocmPackages.rocm-device-libs
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
