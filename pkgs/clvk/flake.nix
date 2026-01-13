{
  description = "Nix flake for clvk - OpenCL on Vulkan";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    clvk-src = {
      url =
        "git+https://github.com/kpet/clvk?rev=78aa08afbc7f2d724924e84505906e4cbec87878&submodules=1";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-utils, clvk-src }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        lib = pkgs.lib;

        # Use LLVM 19 for compatibility
        llvmPackages = pkgs.llvmPackages_19;

        # SPIRV-LLVM-Translator with proper LLVM version
        spirv-llvm-translator =
          pkgs.spirv-llvm-translator.override { inherit (llvmPackages) llvm; };

        # Define clvk derivation
        clvk = pkgs.clang19Stdenv.mkDerivation {
          pname = "clvk";
          version = "git";
          src = clvk-src;

          nativeBuildInputs = with pkgs; [
            cmake
            ninja
            python3
            shaderc
            glslang
          ];

          buildInputs = [
            llvmPackages.llvm
            llvmPackages.clang-unwrapped
            llvmPackages.libclc
            pkgs.vulkan-headers
            pkgs.vulkan-loader
            spirv-llvm-translator
          ];

          # Patches to revert problematic clspv commits
          patches = [
            (pkgs.fetchpatch {
              url =
                "https://github.com/google/clspv/commit/022d17206ec3aca899f72593b8f3d2bf5b5192ec.patch";
              hash = "sha256-RJX4/Eec7UUFED7zudJTAORPjXSUdTKi/YXhIdk/kxU=";
              stripLen = 1;
              extraPrefix = "external/clspv/";
              revert = true;
            })
            (pkgs.fetchpatch {
              url =
                "https://github.com/google/clspv/commit/419bc4ba6d1b6ff01c8f2f8ac2306307d9022cc9.patch";
              hash = "sha256-VzP6/oU3POtxDZ3kH/0IoUTmUzB+Lo3KmQD2ajsq0ko=";
              stripLen = 1;
              extraPrefix = "external/clspv/";
              excludes = [ "external/clspv/deps.json" ];
              revert = true;
            })
            (pkgs.fetchpatch {
              url =
                "https://github.com/google/clspv/commit/48acbf93dccdfca586210713d9d55cde40e40b54.patch";
              hash = "sha256-d8JKmKxLQa6Vxzw0cLXG/ldpxCZ4Iml5w2Tn4aSeCmQ=";
              stripLen = 1;
              extraPrefix = "external/clspv/";
              excludes = [ "external/clspv/deps.json" ];
              revert = true;
            })
            (pkgs.fetchpatch {
              url =
                "https://github.com/google/clspv/commit/ae643967b8a7b0402420b95cf101c179fe059f45.patch";
              hash = "sha256-Czu06caNJjFBVSg6uoWFPJQul8Hhqi/hou/AcymVhI4=";
              stripLen = 1;
              extraPrefix = "external/clspv/";
              excludes = [ "external/clspv/deps.json" ];
              revert = true;
            })
            (pkgs.fetchpatch {
              url =
                "https://github.com/google/clspv/commit/b8c19faca7317d64922396aa2ee44029dbf38b7c.patch";
              hash = "sha256-S2SmeM84XU9Wd2XA3DFmBXK2AEz4tClOgaEGHPoBBaY=";
              stripLen = 1;
              extraPrefix = "external/clspv/";
              excludes = [ "external/clspv/deps.json" ];
              revert = true;
            })
            (pkgs.fetchpatch {
              url =
                "https://github.com/google/clspv/commit/7bfeccd7be6ea317c07de9f8d7ceb86cb2579d20.patch";
              hash = "sha256-qys2hQyciQmkvaD1LF4qoGxbUD0qiO0DTY7ryY+HalU=";
              stripLen = 1;
              extraPrefix = "external/clspv/";
              excludes = [ "external/clspv/deps.json" ];
              revert = true;
            })
          ];

          postPatch = ''
            substituteInPlace external/clspv/lib/CMakeLists.txt \
              --replace $\{CLSPV_LLVM_BINARY_DIR\}/lib/cmake/clang/ClangConfig.cmake \
                ${llvmPackages.clang-unwrapped.dev}/lib/cmake/clang/ClangConfig.cmake

            substituteInPlace external/clspv/CMakeLists.txt \
              --replace $\{CLSPV_LLVM_BINARY_DIR\}/tools/clang/include \
                ${llvmPackages.clang-unwrapped.dev}/include

            # The in-tree build hardcodes a path to the build directory
            # just override it with our proper out-of-tree version
            substituteInPlace src/config.def \
              --replace DEFAULT_LLVMSPIRV_BINARY_PATH \"${spirv-llvm-translator}/bin/llvm-spirv\" \
              --replace DEFAULT_CLSPV_BINARY_PATH \"$out/clspv\"
          '';

          cmakeFlags = let
            # This file is required but its not supplied by LLVM 18, it was only added by LLVM 19.
            llvm_version = pkgs.writeTextDir "LLVMVersion.cmake" ''
              # The LLVM Version number information

              if(NOT DEFINED LLVM_VERSION_MAJOR)
                set(LLVM_VERSION_MAJOR ${
                  lib.versions.major llvmPackages.llvm.version
                })
              endif()
              if(NOT DEFINED LLVM_VERSION_MINOR)
                set(LLVM_VERSION_MINOR ${
                  lib.versions.minor llvmPackages.llvm.version
                })
              endif()
              if(NOT DEFINED LLVM_VERSION_PATCH)
                set(LLVM_VERSION_PATCH ${
                  lib.versions.patch llvmPackages.llvm.version
                })
              endif()
              if(NOT DEFINED LLVM_VERSION_SUFFIX)
                set(LLVM_VERSION_SUFFIX git)
              endif()
            '';
          in [
            "-DCLVK_CLSPV_ONLINE_COMPILER=ON"
            "-DCLVK_BUILD_TESTS=OFF" # Missing: llvm_gtest
            # clspv
            "-DEXTERNAL_LLVM=1"
            "-DCLSPV_LLVM_SOURCE_DIR=${llvmPackages.llvm.src}/llvm"
            "-DCLSPV_CLANG_SOURCE_DIR=${llvmPackages.clang-unwrapped.src}/clang"
            "-DCLSPV_LLVM_CMAKE_MODULES_DIR=${llvm_version}"
            "-DCLSPV_LIBCLC_SOURCE_DIR=${llvmPackages.libclc.src}/libclc"
            "-DCLSPV_LLVM_BINARY_DIR=${llvmPackages.llvm.dev}"
            "-DCLSPV_EXTERNAL_LIBCLC_DIR=${llvmPackages.libclc}/share/clc"
            # SPIRV-LLVM-Translator
            "-DBASE_LLVM_VERSION=${llvmPackages.llvm.version}"
            "-DLLVM_SPIRV_SOURCE=${spirv-llvm-translator.src}"
          ];

          postInstall = ''
            mkdir -p $out/etc/OpenCL/vendors
            echo $out/libOpenCL.so > $out/etc/OpenCL/vendors/clvk.icd
          '';

          meta = with lib; {
            description = "OpenCL implementation on top of Vulkan";
            homepage = "https://github.com/kpet/clvk";
            license = licenses.asl20;
            platforms = platforms.linux;
          };
        };
      in {
        packages.default = clvk;

        apps.default = {
          type = "app";
          program = "${clvk}/bin/clspv";
        };
      });
}
