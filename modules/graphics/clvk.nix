{ settings, inputs, pkgs, lib, ... }: {
  config = lib.mkIf (settings.modules.graphics.enable or false) {
    environment.systemPackages =
      [ inputs.clvk-pkg.packages.${pkgs.stdenv.hostPlatform.system}.default ];

    # Clvk needs to be in extraPackages to be picked up by the ICD loader
    hardware.graphics.extraPackages =
      [ inputs.clvk-pkg.packages.${pkgs.stdenv.hostPlatform.system}.default ];
  };
}
