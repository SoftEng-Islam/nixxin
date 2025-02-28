{ settings, config, lib, pkgs, ... }:
let inherit (lib) mkIf;
in {
  config = lib.optionals (settings.modules.albert_launcher.enable) {
    environment.systemPackages = with pkgs; [ albert ];
  };
}
