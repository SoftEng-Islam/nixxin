{ settings, pkgs, ... }:
{
  services.mysql = {
    enable = settings.modules.development.databases.mariadb.enable;
    package = pkgs.mariadb;
  };

  environment.systemPackages = with pkgs; [
    mariadb
    mysql-workbench
  ];
}
