{ settings, config, lib, pkgs, ... }:
let inherit (lib) mkIf;
in {
  config = mkIf (settings.modules.development.databases.mysql.enable) {
    services.mysql = {
      enable = true;
      package = pkgs.mariadb;
      # ensureDatabases = [ "wordpress" ];
      # ensureUsers = [{ name = "softeng"; }];
    };
    environment.systemPackages = with pkgs; [ mysql84 mariadb ];
  };
}
