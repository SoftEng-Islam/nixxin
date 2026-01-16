{
  description = "CLVK (OpenCL on Vulkan) for NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    clvk-src = {
      url = "git+https://github.com/kpet/clvk.git?submodules=1";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, clvk-src }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" ];
      lib = nixpkgs.lib;
      forAllSystems = f:
        lib.genAttrs systems
        (system: let pkgs = nixpkgs.legacyPackages.${system}; in f system pkgs);
    in rec {
      packages = forAllSystems (system: pkgs: rec {
        llvmPackages = pkgs.llvmPackages_19;

        spirv-llvm-translator = pkgs.spirv-llvm-translator;
        spirv-tools = pkgs.spirv-tools;

        clvk = pkgs.callPackage ({ stdenv, cmake, ninja, python3, llvmPackages
          , spirv-tools, vulkan-headers, vulkan-loader, shaderc, glslang
          , fetchpatch, spirv-llvm-translator }:
          stdenv.mkDerivation {
            pname = "clvk";
            version = "git";

            src = clvk-src;

            nativeBuildInputs = [ cmake ninja python3 shaderc glslang ];
            buildInputs = [ llvmPackages.llvm vulkan-headers vulkan-loader ];

            postPatch = ''
              substituteInPlace external/clspv/lib/CMakeLists.txt \
                --replace $\{CLSPV_LLVM_BINARY_DIR\}/lib/cmake/clang/ClangConfig.cmake \
                  ${llvmPackages.clang-unwrapped.dev}/lib/cmake/clang/ClangConfig.cmake

              substituteInPlace external/clspv/CMakeLists.txt \
                --replace $\{CLSPV_LLVM_BINARY_DIR\}/tools/clang/include \
                  ${llvmPackages.clang-unwrapped.dev}/include

              substituteInPlace src/config.def \
                --replace DEFAULT_LLVMSPIRV_BINARY_PATH \"${spirv-llvm-translator}/bin/llvm-spirv\" \
                --replace DEFAULT_CLSPV_BINARY_PATH \"$out/clspv\"
            '';

            cmakeFlags =
              [ "-DCLVK_CLSPV_ONLINE_COMPILER=ON" "-DCLVK_BUILD_TESTS=OFF" ];

            postInstall = ''
              mkdir -p $out/etc/OpenCL/vendors
              echo $out/libOpenCL.so > $out/etc/OpenCL/vendors/clvk.icd
            '';
          }) {
            inherit llvmPackages spirv-llvm-translator spirv-tools;
            stdenv = pkgs.clang19Stdenv;
          };
      });

      overlays.default = final: prev: {
        clvk = self.packages.${final.system}.clvk;
      };

      devShells = forAllSystems (system: pkgs:
        let
          ld_library_path = lib.makeLibraryPath [ pkgs.khronos-ocl-icd-loader ];
        in {
          clvk = pkgs.mkShell {
            name = "nix-opencl-clvk";

            packages = [
              pkgs.khronos-ocl-icd-loader
              pkgs.clinfo
              self.packages.${system}.clvk
            ];

            shellHook = ''
              export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:${ld_library_path}"
              export OCL_ICD_VENDORS="${
                self.packages.${system}.clvk
              }/etc/OpenCL/vendors/"
            '';
          };
        });
    };
}
