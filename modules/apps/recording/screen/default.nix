{ settings, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  _imports = [
    (lib.optional settings.modules.apps.recording.screen.blue
      ./blue_recorder.nix)
    (lib.optional settings.modules.apps.recording.screen.gsr
      ./gpu_screen_recorder.nix)
    (lib.optional settings.modules.apps.recording.screen.obs ./obs.nix)
    (lib.optional settings.modules.apps.recording.screen.wf ./wf_recorder.nix)
  ];
in mkIf (settings.modules.apps.recording.screen.enable) {
  imports = lib.flatten _imports;
}
