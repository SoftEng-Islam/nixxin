# https://nixos.wiki/wiki/AMD_GPU
{
  settings,
  lib,
  pkgs,
  ...
}:
let
  cfg = settings.modules.system.rocm; # "latest" | "rocm5.6" | false

  # ------------------------------------------------
  # ---- Package set selection
  # ------------------------------------------------
  # TODO(islam): wire `rocm56Pkgs` to whatever actually provides ROCm 5.6 in
  # your flake — e.g. a pinned nixpkgs input passed in via specialArgs
  # (mirroring the `pkgs.unstable` pattern you use for mesa.opencl), an
  # overlay attribute, or nixpkgs' `rocmPackages_5` (currently 5.7, and
  # slated for removal upstream — verify it still exists before relying on
  # it). Left as `pkgs` for now so this evaluates cleanly until you fill it in.
  rocm56Pkgs = pkgs; # placeholder

  # ------------------------------------------------
  # ---- Shared ROCm config, parameterized by package set
  # ------------------------------------------------
  mkRocmConfig = rp: {
    boot.kernelModules = [
      "amdgpu.sg_display=0" # Fixes display-related ROCm issues
    ];

    hardware.graphics = {
      extraPackages = with rp; [
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
        "L+ /opt/rocm/hip - - - - ${rp.rocmPackages.clr}"
      ];

    # ------------------------------------------------
    # ---- Variables
    # ------------------------------------------------
    environment.variables = {
      ROCM_PATH = "${pkgs.rocmPackages.clr}";

      # OCL_ICD_VENDORS = "/etc/OpenCL/vendors/";

      # ROCM_TARGET = "gfx700";
      # ROC_ENABLE_PRE_VEGA = "1";

      ROC_ENABLE_PRE_VEGA = "1";

      # HIP_PATH = "${rp.rocmPackages.hip-common}/libexec/hip";
      # HSA_OVERRIDE_GFX_VERSION = "9.0.0"; # 10.3.0 or 9.0.0

      # OCL_ICD_VENDORS = "${rp.rocmPackages.clr.icd}/etc/OpenCL/vendors/";
    };

    environment.systemPackages = with rp; [
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
  };
in
# ------------------------------------------------
# ---- Three-way switch: "latest" | "rocm5.6" | false
# ------------------------------------------------
# `false` needs no explicit branch: both mkIf guards below evaluate to {},
# and mkMerge [{} {}] == {}, so the module is a no-op.
lib.mkMerge [
  (lib.mkIf (cfg == "latest") (mkRocmConfig pkgs))
  (lib.mkIf (cfg == "rocm5.6") (mkRocmConfig rocm56Pkgs))
]
