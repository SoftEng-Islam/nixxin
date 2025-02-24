{ settings, pkgs, ... }: {
  imports = [
    # ./blue.nix
    # ./gpu_recorder.nix
    ./obs.nix
    #  ./wf_recorder.nix
  ];
}
