{
  description = "Nix flake for clvk - OpenCL on Vulkan";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    clvk-src = {
      url = "github:kpet/clvk";
      flake = false;
    };
  };
  outputs = { self, nixpkgs, flake-utils, clvk-src }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        clvk = pkgs.stdenv.mkDerivation {
          pname = "clvk";
          version = "latest";
          src = clvk-src;

          nativeBuildInputs = [ pkgs.cmake pkgs.ninja pkgs.python3 pkgs.git ];

          buildInputs = with pkgs; [
            vulkan-loader
            vulkan-headers
            spirv-headers
            spirv-tools
            glslang
            llvmPackages.clang
            opencl-headers
            pkg-config
          ];

          cmakeFlags = [
            "-DCMAKE_BUILD_TYPE=Release"
            "-DBUILD_TESTS=OFF"
            "-DBUILD_EXAMPLES=OFF"
          ];

          meta = with pkgs.lib; {
            description = "OpenCL implementation on top of Vulkan";
            homepage = "";
          };
        };
      in {
        packages.default = clvk;
        apps.default = {
          type = "app";
          program = "${clvk}/bin/clvk";
        };
      });
}
