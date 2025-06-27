{ settings, config, lib, pkgs, ... }:
let inherit (lib) mkIf;
in {
  config = mkIf (settings.modules.development.databases.monogodb.enable) {
    services.mongodb.enable = true;
    environment.systemPackages = with pkgs; [
      mongodb
      mongodb-compass
      mongodb-tools
    ];
  };
}
