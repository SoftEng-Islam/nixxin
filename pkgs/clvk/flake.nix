{
  description = "OpenCL packages for NixOS";

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

        # -------------------
        # CLVK
        # -------------------
        # We define 'd' as a helper for "$" to bypass Nix interpolation errors completely.
        clvk = let d = "$";
        in pkgs.stdenv.mkDerivation {
          pname = "clvk";
          version = "git";

          src = pkgs.fetchFromGitHub {
            owner = "kpet";
            repo = "clvk";
            rev = "e0630327e3fda63dd5274376e95a9a48a3c9e3e6";
            # ⚠ You must update this hash or the build will fail immediately after this fix!
            sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
            fetchSubmodules = true;
          };

          nativeBuildInputs =
            [ pkgs.cmake pkgs.ninja pkgs.python3 pkgs.shaderc pkgs.glslang ];
          buildInputs =
            [ llvmPackages.llvm pkgs.vulkan-headers pkgs.vulkan-loader ];

          # We can remove preConfigure; fetchSubmodules=true handles the sources.

          postPatch = ''
            # 1. Fix CMake files
            # We use ${d} to safely insert a '$' without triggering Nix variable lookup.
            substituteInPlace external/clspv/lib/CMakeLists.txt \
              --replace '${d}{CLSPV_LLVM_BINARY_DIR}/lib/cmake/clang/ClangConfig.cmake' \
              "${llvmPackages.clang-unwrapped.dev}/lib/cmake/clang/ClangConfig.cmake"

            substituteInPlace external/clspv/CMakeLists.txt \
              --replace '${d}{CLSPV_LLVM_BINARY_DIR}/tools/clang/include' \
              "${llvmPackages.clang-unwrapped.dev}/include"

            # 2. Fix config.def
            # We use \" to pass literal double quotes to the C compiler.
            substituteInPlace src/config.def \
              --replace 'DEFAULT_LLVMSPIRV_BINARY_PATH' "\"${pkgs.spirv-llvm-translator}/bin/llvm-spirv\"" \
              --replace 'DEFAULT_CLSPV_BINARY_PATH' "\"$out/clspv\""
          '';

          cmakeFlags =
            [ "-DCLVK_CLSPV_ONLINE_COMPILER=ON" "-DCLVK_BUILD_TESTS=OFF" ];

          postInstall = ''
            mkdir -p $out/etc/OpenCL/vendors
            echo $out/libOpenCL.so > $out/etc/OpenCL/vendors/clvk.icd
          '';
        };

        # -------------------
        # Mesa (OpenCL)
        # -------------------
        mesa = pkgs.stdenv.mkDerivation {
          pname = "mesa";
          version = "git";

          src = pkgs.fetchgit {
            url = "https://gitlab.freedesktop.org/mesa/mesa.git";
            rev = "master";
            sha256 =
              "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; # replace
          };

          nativeBuildInputs =
            [ pkgs.meson pkgs.ninja pkgs.python3 pkgs.pkg-config ];
          buildInputs =
            [ llvmPackages.llvm pkgs.spirv-tools pkgs.spirv-llvm-translator ];

          mesonFlags = [ "-Db_ndebug=false" "--buildtype=debug" ];
        };

        # -------------------
        # POCL
        # -------------------
        pocl = pkgs.stdenv.mkDerivation {
          pname = "pocl";
          version = "git";

          src = pkgs.fetchFromGitHub {
            owner = "pocl";
            repo = "pocl";
            rev = "main";
            sha256 =
              "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; # replace
          };

          nativeBuildInputs =
            [ pkgs.cmake pkgs.ninja pkgs.python3 llvmPackages.clang ];
          buildInputs = [
            llvmPackages.llvm
            pkgs.ocl-icd
            pkgs.spirv-llvm-translator
            pkgs.libxml2
            pkgs.pkg-config
          ];

          cmakeFlags = [
            "-DENABLE_ICD=ON"
            "-DENABLE_TESTS=OFF"
            "-DENABLE_EXAMPLES=OFF"
            "-DSTATIC_LLVM=ON"
          ];
        };

        # -------------------
        # Shady
        # -------------------
        shady = pkgs.stdenv.mkDerivation {
          pname = "shady";
          version = "git";

          src = pkgs.fetchFromGitHub {
            owner = "shady-gang";
            repo = "shady";
            rev = "main";
            sha256 =
              "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; # replace
            fetchSubmodules = true;
          };

          nativeBuildInputs = [ pkgs.cmake pkgs.ninja pkgs.python3 ];
          buildInputs = [ llvmPackages.llvm pkgs.libxml2 ];

          cmakeFlags =
            [ "-DSHADY_ENABLE_SAMPLES=OFF" "-DSHADY_USE_FETCHCONTENT=OFF" ];
        };
      });

      # -------------------
      # Dev shells
      # -------------------
      devShells = forAllSystems (system: pkgs: rec {
        clvk = pkgs.mkShell {
          packages =
            [ pkgs.khronos-ocl-icd-loader pkgs.clinfo packages.${system}.clvk ];

          shellHook = ''
            export OCL_ICD_VENDORS="${
              packages.${system}.clvk
            }/etc/OpenCL/vendors/"
          '';
        };

        mesa = pkgs.mkShell {
          packages =
            [ pkgs.khronos-ocl-icd-loader pkgs.clinfo packages.${system}.mesa ];
        };

        pocl = pkgs.mkShell {
          packages =
            [ pkgs.khronos-ocl-icd-loader pkgs.clinfo packages.${system}.pocl ];
        };
      });
    };
}
