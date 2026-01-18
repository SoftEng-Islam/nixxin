{ settings, inputs, pkgs, lib, ... }:
let
  system = pkgs.stdenv.hostPlatform.system;
  nixos-opencl = inputs.nixos-opencl;
in {
  environment.systemPackages = [ pkgs.clinfo pkgs.opencl-headers ];
  # hardware.graphics.extraPackages = [ pkgs.khronos-opencl-icd-loader ];
  environment.sessionVariables = {
    # OCL_ICD_VENDORS = let
    #   drivers = [
    #     nixos-opencl.packages.${system}.pocl
    #     nixos-opencl.packages.${system}.clvk
    #   ];
    # in pkgs.symlinkJoin {
    #   name = "opencl-vendors";
    #   paths = drivers;
    # };
  };

}
