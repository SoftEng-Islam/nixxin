{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.recording.screen.obs) {
  # https://obsproject.com/
  environment.systemPackages = with pkgs;
    [
      obs-studio # Free and open source software for video recording and live streaming
    ];
}
