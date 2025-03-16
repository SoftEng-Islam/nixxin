{ settings, config, lib, pkgs, ... }:
let inherit (lib) mkIf;
in {
  config = mkIf (settings.modules.development.databases.mysql.enable) {
    services.mysql = {
      enable = true;
      package = pkgs.mariadb;
    };
    environment.systemPackages = with pkgs; [ mariadb maria ];
  };
}
