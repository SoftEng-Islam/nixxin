{ settings, config, lib, pkgs, ... }:
let inherit (lib) mkIf;
in {
  config = mkIf (settings.modules.development.databases.mysql.enable) {
    services.mysql = {
      enable = true;
      package = pkgs.mariadb;
      ensureDatabases = [ "wordpress" ];
      ensureUsers = [{
        name = "wordpress";
        password = "*77B48D6366D102139D3719F48B811EAE123B2CA5";
        privileges = { "wordpress.*" = "ALL PRIVILEGES"; };
      }];
    };
    environment.systemPackages = with pkgs; [ mysql84 mariadb ];
  };
}
