{ settings, config, lib, pkgs, ... }:
let inherit (lib) optionals mkIf;
in {

  # "pocl" OR "opencl"
  imports = optionals (settings.modules.computing.enable)
    [ (./. + settings.modules.computing.default + ".nix") ];

  config = mkIf (settings.modules.computing.enable) {

  };

}
