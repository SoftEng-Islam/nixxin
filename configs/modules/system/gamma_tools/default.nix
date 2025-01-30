{ settings, pkgs, ... }: {
  imports = [
    ./gammastep.nix
    ./hyprsunset.nix
    ./wl-gammactl.nix
    ./wlsunset.nix
    ./wluma.nix
  ];
}
