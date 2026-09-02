# https://nixos.wiki/wiki/AMD_GPU
# Picasso/Raven Ridge APUs (e.g. Ryzen 3400G, gfx902) need ROCm 5.x; current
# nixpkgs ships ROCm 7.x which dropped these targets. Pin HIP/OpenCL to nixos-23.11.
{
  settings,
  lib,
  pkgs,
  pkgs-older,
  ...
}:
let
  rocm = pkgs-older.rocmPackages;
in
lib.mkIf (settings.modules.system.rocm.enable or false) {
  boot.kernelParams = [
    "amdgpu.sg_display=0" # Avoid display glitches with ROCm on APUs
  ];

  hardware.graphics.extraPackages = [
    rocm.clr.icd
  ];

  systemd.tmpfiles.rules = [
    "f /dev/shm/looking-glass 0660 ${settings.user.username} kvm -"
    "L+ /opt/rocm/hip - - - - ${rocm.clr}"
  ];

  environment.etc."OpenCL/vendors/amdocl64.icd".text = "${rocm.clr.icd}/lib/libamdocl64.so";

  environment.variables = {
    ROCM_PATH = "${rocm.rocm-runtime}";
    HIP_PATH = "${rocm.hip-common}/libexec/hip";
    # Picasso (Ryzen 3400G) reports gfx902; older ROCm builds need this override.
    HSA_OVERRIDE_GFX_VERSION = "9.0.6";
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
}
