{
  config,
  pkgs,
  inputs,
  ...
}:

let
  pkgs-2405 = inputs.nixpkgs-2405.legacyPackages.${pkgs.stdenv.hostPlatform.system};

  # 1. Custom compiled Blender 4.2 LTS (already built and cached in /nix/store)
  blender-42-vega =
    (pkgs-2405.blender.override {
      hipSupport = true;
    }).overrideAttrs
      (old: {
        cmakeFlags = (old.cmakeFlags or [ ]) ++ [
          "-DCYCLES_HIP_BINARIES_ARCH=gfx900;gfx1010;gfx1030;gfx1100"
        ];
      });

  # 2. FHS container to expose host Mesa/DRI OpenGL & ROCm drivers
  blender-fhs = pkgs.buildFHSEnv {
    name = "blender";
    targetPkgs = pkgs: [
      blender-42-vega
      pkgs.rocmPackages.clr
      pkgs.mesa
      pkgs.libGL
      pkgs.libglvnd
      pkgs.libepoxy
      pkgs.xorg.libX11
      pkgs.xorg.libXext
      pkgs.xorg.libXi
      pkgs.xorg.libXrender
      pkgs.xorg.libXrandr
      pkgs.xorg.libXfixes
      pkgs.xorg.libXcursor
      pkgs.xorg.libXinerama
      pkgs.xorg.libXxf86vm
    ];
    profile = ''
      export HSA_OVERRIDE_GFX_VERSION=9.0.0
      export CYCLES_HIP_FORCE_ENABLE=1
      export LD_LIBRARY_PATH=/run/opengl-driver/lib:$LD_LIBRARY_PATH
    '';
    runScript = "blender";
    extraInstallCommands = ''
      mkdir -p $out/share
      cp -r ${blender-42-vega}/share/* $out/share/ 2>/dev/null || true
    '';
  };
in
{
  environment.systemPackages = [ blender-fhs ];
}
