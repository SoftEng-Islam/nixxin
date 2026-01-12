{
  description = "Nix flake for clvk - OpenCL on Vulkan";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    clvk-src = {
      url = "git+https://github.com/kpet/clvk?submodules=1";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-utils, clvk-src }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};

        # Fetch LLVM manually because clspv needs it and we can't run the python script
        llvmProject = pkgs.fetchFromGitHub {
          owner = "llvm";
          repo = "llvm-project";
          rev = "e68a20e0b7623738d6af736d3aa02625cba6126a";
          sha256 = "0qs9dxxyva2zj7371ppzn30hxh2n123s3rp52cdi89zyk7ksjcr2";
        };

        # Define clvk derivation since it's missing from nixpkgs
        clvk = pkgs.stdenv.mkDerivation {
          pname = "clvk";
          version = "latest";
          src = clvk-src;

          nativeBuildInputs = with pkgs; [ cmake ninja python3 git pkg-config ];

          buildInputs = with pkgs; [
            vulkan-loader
            vulkan-headers
            spirv-headers
            spirv-tools
            glslang
            ncurses # sometimes needed for llvm
          ];

          cmakeFlags = [
            "-DCMAKE_BUILD_TYPE=Release"
            "-DCLVK_BUILD_TESTS=OFF"
            "-DCLVK_BUILD_EXAMPLES=OFF"
          ];

          # Fix for "SPIRV-Tools-opt not found" if it relies on external or submodules
          # We are letting it use submodules by fetching them in src

          preConfigure = ''
            # Fix module permissions if needed (git submodules sometimes leave read-only)
            chmod -R u+w .

            # Provide LLVM to clspv
            mkdir -p external/clspv/third_party/llvm
            cp -r --no-preserve=mode ${llvmProject}/* external/clspv/third_party/llvm/

            # Ensure CMAKE_PREFIX_PATH finds vulkan
            export CMAKE_PREFIX_PATH=${pkgs.vulkan-headers}:${pkgs.vulkan-loader}:$CMAKE_PREFIX_PATH
          '';

          installPhase = ''
            mkdir -p $out/bin $out/lib
            cp -d *.so* $out/lib/
            # Check if clvk binary exists or if it's just a lib
            if [ -f clvk ]; then
              cp clvk $out/bin/
            fi
            # Copy clspv if built
            if [ -f clspv ]; then
               cp clspv $out/bin/
            elif [ -f external/clspv/bin/clspv ]; then
               cp external/clspv/bin/clspv $out/bin/
            fi
          '';

          meta = with pkgs.lib; {
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
          program =
            "${clvk}/bin/clvk"; # This binary might not exist, usually it's a library
        };
      });
}
