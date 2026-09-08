{
  settings,
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

let
  pkgs-2405 = inputs.nixpkgs-2405.legacyPackages.${pkgs.stdenv.hostPlatform.system};

  # 1. Compile Blender 4.2 LTS with explicit gfx900 HIP binary target
  blender-42-vega = pkgs-2405.pkgsRocm.blender.overrideAttrs (old: {
    cmakeFlags = (old.cmakeFlags or [ ]) ++ [
      "-DCYCLES_HIP_BINARIES_ARCH=gfx900;gfx1010;gfx1030;gfx1100"
    ];
  });

  # 2. Preserve desktop menu launcher icons and inject ROCm flags
  blender-42-lts = pkgs.symlinkJoin {
    name = "blender-42-lts";
    paths = [ blender-42-vega ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/blender \
        --set HSA_OVERRIDE_GFX_VERSION 9.0.0 \
        --set CYCLES_HIP_FORCE_ENABLE 1 \
        --prefix LD_LIBRARY_PATH : "${pkgs.rocmPackages.clr}/lib:/run/opengl-driver/lib"
    '';
  };
in
lib.mkIf (settings.modules.graphics.blender.enable or false) {
  environment.systemPackages = [ blender-42-lts ];
}
