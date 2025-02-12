{ settings, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  _imports = [
    (lib.optional settings.modules.apps.recording.screen.enable ./screen)
    (lib.optional settings.modules.apps.recording.sound.enable ./sound)
  ];
in mkIf (settings.modules.apps.recording.enable) {
  import = lib.flatten _imports;
  environment.systemPackages = with pkgs; [
    gpu-screen-recorder # A screen recorder that has minimal impact on system performance by recording a window using the GPU only
    gpu-screen-recorder-gtk # GTK frontend for gpu-screen-recorder.
  ];
}
