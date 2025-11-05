# https://git.dec05eba.com/gpu-screen-recorder/about/
{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.recording.screen.gpu_recorder) {
  # https://obsproject.com/
  environment.systemPackages = with pkgs; [
    gpu-screen-recorder
    gpu-screen-recorder-gtk
  ];
}
