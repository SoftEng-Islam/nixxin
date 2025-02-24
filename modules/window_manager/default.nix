{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.window_manager.enable) {
  imports = [ ./hyprland ];

}
