{ settings, pkgs, ... }: {
  imports = [ ./gpu_recorder.nix ./obs.nix ./wf_recorder.nix ];
}
