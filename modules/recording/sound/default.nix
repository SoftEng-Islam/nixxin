{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.recording.sound.enable) {
  environment.systemPackages = with pkgs; [ ];
}
