{ inputs, pkgs, ... }:
let
  system = pkgs.stdenv.hostPlatform.system;
  nixos-opencl = inputs.nixos-opencl;
in {
  environment.systemPackages = with pkgs; [ clinfo opencl-headers ];
  # hardware.graphics.extraPackages = [ nixos-opencl.packages.${system}.clvk ];
  environment.sessionVariables = {
    OCL_ICD_VENDORS = let
      drivers = [
        # nixos-opencl.packages.${system}.pocl
        nixos-opencl.packages.${system}.clvk
      ];
    in pkgs.symlinkJoin {
      name = "opencl-vendors";
      paths = drivers;
    };
  };

}
