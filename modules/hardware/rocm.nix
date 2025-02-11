{ settings, lib, pkgs, ... }: {
  # systemd.tmpfiles.rules = let
  #   rocmEnv = pkgs.symlinkJoin {
  #     name = "rocm-combined";
  #     paths = with pkgs.rocmPackages; [ rocblas hipblas clr ];
  #   };
  # in [ "L+    /opt/rocm   -    -    -     -    ${rocmEnv}" ];

  # environment.etc."OpenCL/vendors/amdocl64.icd".text = ''
  #   ${pkgs.rocmPackages.clr.icd}/lib/libamdocl64.so
  # '';

  # environment.etc."OpenCL/vendors/amdocl64.icd".source =
  #   pkgs.rocmPackages.clr.icd;

  environment.variables = {
    # ROCM_PATH = "${pkgs.rocmPackages.rocm-runtime}";
    ROCM_TARGET = "gfx700";
    ROC_ENABLE_PRE_VEGA = "1";
  };
  environment.systemPackages = with pkgs; [
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
    rocmPackages.clr
  ];
  home-manager.users."${settings.users.selected.username}" = {

  };
}
