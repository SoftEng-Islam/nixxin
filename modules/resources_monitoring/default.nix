{ settings, config, lib, pkgs, ... }:
let inherit (lib) mkIf;
in {
  imports =
    lib.optionals (settings.modules.resources_monitoring.enable) [ ./btop.nix ];
  config = mkIf (settings.modules.resources_monitoring.enable) {
    environment.systemPackages = with pkgs;
      [
        resources # Monitor your system resources and processes
      ];
  };
}
