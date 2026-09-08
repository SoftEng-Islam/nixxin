{
  config,
  pkgs,
  inputs,
  ...
}:

let
  pkgs-2405 = inputs.nixpkgs-2405.legacyPackages.${pkgs.stdenv.hostPlatform.system};

  # 1. Custom compiled Blender 4.2 LTS (already cached in /nix/store)
  blender-42-vega =
    (pkgs-2405.blender.override {
      hipSupport = true;
    }).overrideAttrs
      (old: {
        cmakeFlags = (old.cmakeFlags or [ ]) ++ [
          "-DCYCLES_HIP_BINARIES_ARCH=gfx900;gfx1010;gfx1030;gfx1100"
        ];
      });

  # 2. Native wrapper bridging 24.05 binary to your 26.05 Wayland/Mesa drivers
  blender-42-lts = pkgs.symlinkJoin {
    name = "blender-42-lts";
    paths = [ blender-42-vega ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/blender \
        --set HSA_OVERRIDE_GFX_VERSION 9.0.0 \
        --set CYCLES_HIP_FORCE_ENABLE 1 \
        --set __EGL_VENDOR_LIBRARY_DIRS "/run/opengl-driver/share/glvnd/egl_vendor.d" \
        --set LIBGL_DRIVERS_PATH "/run/opengl-driver/lib/dri" \
        --prefix LD_LIBRARY_PATH : "/run/opengl-driver/lib:${pkgs.rocmPackages.clr}/lib"
    '';
  };
in
{
  # Add the wrapped package to your system
  environment.systemPackages = [ blender-42-lts ];
}
