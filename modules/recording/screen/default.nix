{ settings, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  _imports = [
    (lib.optional settings.modules.recording.screen.blue ./blue.nix)
    (lib.optional settings.modules.recording.screen.gsr ./gpu_recorder.nix)
    (lib.optional settings.modules.recording.screen.obs ./obs.nix)
    (lib.optional settings.modules.recording.screen.wf ./wf_recorder.nix)
  ];
in mkIf (settings.modules.recording.screen.enable) {
  imports = lib.flatten _imports;
}
