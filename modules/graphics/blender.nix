{
  lib,
  pkgs,
  inputs,
  settings,
  ...
}:

let
  pkgs-2405 = inputs.nixpkgs-2405.legacyPackages.${pkgs.stdenv.hostPlatform.system};

  # Keep Blender 4.1.1 from nixos-24.05 (HIP still ships Vega/gfx900 kernels).
  blender-42-vega =
    (pkgs-2405.blender.override {
      hipSupport = true;
    }).overrideAttrs
      (old: {
        cmakeFlags = (old.cmakeFlags or [ ]) ++ [
          "-DCYCLES_HIP_BINARIES_ARCH=gfx900;gfx1010;gfx1030;gfx1100"
        ];
      });

  # System /run/opengl-driver is Mesa 26+, which breaks this binary's epoxy/EGL
  # (EGL_BAD_PARAMETER → "Couldn't find current GLX or EGL context"). Use the
  # Mesa that matches the 24.05 package set instead.
  mesaDrivers = pkgs-2405.mesa.drivers;
  rocmClr = pkgs-2405.rocmPackages.clr;

  blender-42-lts = pkgs.symlinkJoin {
    name = "blender-42-lts";
    paths = [ blender-42-vega ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/blender \
        --set HSA_OVERRIDE_GFX_VERSION 9.0.0 \
        --set CYCLES_HIP_FORCE_ENABLE 1 \
        --set __EGL_VENDOR_LIBRARY_DIRS "${mesaDrivers}/share/glvnd/egl_vendor.d" \
        --set LIBGL_DRIVERS_PATH "${mesaDrivers}/lib/dri" \
        --prefix LD_LIBRARY_PATH : "${mesaDrivers}/lib:${rocmClr}/lib"
    '';
  };
in
{
  config = lib.mkIf (
    (settings.modules.graphics.enable or false) && (settings.modules.graphics.blender or false)
  ) {
    environment.systemPackages = [ blender-42-lts ];
  };
}
