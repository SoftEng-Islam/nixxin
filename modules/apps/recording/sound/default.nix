{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.apps.recording.sound.enable) {
  environment.systemPackages = with pkgs; [ ];
}
