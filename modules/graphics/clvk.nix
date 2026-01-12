{ settings, inputs, pkgs, lib, ... }:
let
  clvk-base =
    inputs.clvk-pkg.packages.${pkgs.stdenv.hostPlatform.system}.default;
  # Create a wrapper that excludes libOpenCL.so to avoid conflict with rocmPackages.clr
  # This wrapper only includes bin, etc (ICD), and libraries except libOpenCL.so
  clvk-compat = pkgs.runCommand "clvk-compat" { } ''
    mkdir -p $out/bin $out/etc $out/lib

    # Symlink bins if they exist
    if [ -d "${clvk-base}/bin" ]; then
      ln -s ${clvk-base}/bin/* $out/bin/
    fi

    # Symlink etc (ICD)
    if [ -d "${clvk-base}/etc" ]; then
      cp -r ${clvk-base}/etc/* $out/etc/
    fi

    # Symlink libs, excluding libOpenCL.so
    if [ -d "${clvk-base}/lib" ]; then
      for f in ${clvk-base}/lib/*; do
        name=$(basename "$f")
        if [[ "$name" != "libOpenCL.so"* ]]; then
          ln -s "$f" $out/lib/
        fi
      done
    fi
  '';
in {
  config = lib.mkIf (settings.modules.graphics.enable or false) {
    environment.systemPackages = [ clvk-compat ];

    # Clvk needs to be in extraPackages to be picked up by the ICD loader
    hardware.graphics.extraPackages = [ clvk-compat ];
  };
}
