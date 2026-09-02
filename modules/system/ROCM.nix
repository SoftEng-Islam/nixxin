# https://nixos.wiki/wiki/AMD_GPU
# modules.system.rocm: "none" | "new" | "old"
# - none: no ROCm/HIP stack (Mesa Rusticl OpenCL only)
# - new:  ROCm from current nixpkgs (ROCm 7.x, discrete GPUs)
# - old:  ROCm 5.7 from nixos-23.11 (Picasso/Raven APUs, gfx902)
{
  settings,
  lib,
  pkgs,
  pkgs-older,
  ...
}:
let
  rocmMode = settings.modules.system.rocm;
  rocmEnabled = rocmMode != "none";
  useOldRocm = rocmMode == "old";

  rocm =
    if useOldRocm then
      pkgs-older.rocmPackages
    else
      pkgs.rocmPackages;

  mkRocmConfig = {
    extraKernelParams ? [ ],
    hsaOverride ? null,
    preVega ? false,
  }:
    {
      boot.kernelParams = [
        "amdgpu.sg_display=0"
      ] ++ extraKernelParams;

      hardware.graphics.extraPackages = [
        rocm.clr.icd
        rocm.clr
      ];

      systemd.tmpfiles.rules = [
        "f /dev/shm/looking-glass 0660 ${settings.user.username} kvm -"
        "L+ /opt/rocm/hip - - - - ${rocm.clr}"
      ];

      environment.etc."OpenCL/vendors/amdocl64.icd".text = "${rocm.clr}/lib/libamdocl64.so";

      environment.variables = {
        ROCM_PATH = "${rocm.rocm-runtime}";
        HIP_PATH = "${rocm.hip-common}/libexec/hip";
      }
      // lib.optionalAttrs (hsaOverride != null) {
        HSA_OVERRIDE_GFX_VERSION = hsaOverride;
      }
      // lib.optionalAttrs preVega {
        ROC_ENABLE_PRE_VEGA = "1";
      };

      environment.systemPackages = with rocm; [
        clr
        hip-common
        hipblas
        hipcc
        rocm-runtime
        rocminfo
        rocm-smi
        rpp
      ] ++ [
        pkgs.clinfo
      ];
    };
in
lib.mkIf rocmEnabled (
  if useOldRocm then
    mkRocmConfig {
      # Picasso (Ryzen 3400G) reports gfx902; ROCm 5.7 needs this override.
      hsaOverride = "9.0.6";
    }
  else
    mkRocmConfig { }
)
