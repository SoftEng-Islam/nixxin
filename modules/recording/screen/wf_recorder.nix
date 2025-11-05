# https://github.com/ammen99/wf-recorder
{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.recording.screen.wf_recorder) {
  environment.systemPackages = with pkgs;
    [
      wf-recorder # Utility program for screen recording of wlroots-based compositors
    ];
}
