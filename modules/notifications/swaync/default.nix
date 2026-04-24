{ settings, config, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.notifications.swaync.enable or false) {
  environment.systemPackages = with pkgs; [ swaynotificationcenter ];
}
