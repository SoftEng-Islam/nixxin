{
  description = "CLVK (OpenCL on Vulkan) for NixOS";

  inputs = { nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11"; };

  outputs = { self, nixpkgs }:
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

        clvk = pkgs.stdenv.mkDerivation {
          pname = "clvk";
          version = "git";

          # fetch inside derivation
          src = pkgs.fetchFromGitHub {
            owner = "kpet";
            repo = "clvk";
            rev = "e0630327e3fda63dd5274376e95a9a48a3c9e3e6";
            sha256 =
              "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; # replace with actual hash
            fetchSubmodules = true;
          };

          nativeBuildInputs =
            [ pkgs.cmake pkgs.ninja pkgs.python3 pkgs.shaderc pkgs.glslang ];
          buildInputs =
            [ llvmPackages.llvm pkgs.vulkan-headers pkgs.vulkan-loader ];

          preConfigure = ''
            cd $src/external/clspv
            python3 utils/fetch_sources.py
          '';

          postPatch = ''
            substituteInPlace $src/external/clspv/lib/CMakeLists.txt \
              --replace $\{CLSPV_LLVM_BINARY_DIR\}/lib/cmake/clang/ClangConfig.cmake \
                ${llvmPackages.clang-unwrapped.dev}/lib/cmake/clang/ClangConfig.cmake

            substituteInPlace $src/external/clspv/CMakeLists.txt \
              --replace $\{CLSPV_LLVM_BINARY_DIR\}/tools/clang/include \
                ${llvmPackages.clang-unwrapped.dev}/include

            substituteInPlace $src/src/config.def \
              --replace DEFAULT_LLVMSPIRV_BINARY_PATH "${spirv-llvm-translator}/bin/llvm-spirv" \
              --replace DEFAULT_CLSPV_BINARY_PATH "$out/clspv"
          '';

          cmakeFlags =
            [ "-DCLVK_CLSPV_ONLINE_COMPILER=ON" "-DCLVK_BUILD_TESTS=OFF" ];

          postInstall = ''
            mkdir -p $out/etc/OpenCL/vendors
            echo $out/libOpenCL.so > $out/etc/OpenCL/vendors/clvk.icd
          '';

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
