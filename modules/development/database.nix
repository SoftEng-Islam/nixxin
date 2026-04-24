{ pkgs, ... }:

{
  services.mongodb.enable = true;
  systemd.services.mongodb.serviceConfig.LimitNOFILE = 64000;

  environment.systemPackages = with pkgs; [
    # Modern and easy to use SQL client for MySQL, Postgres, SQLite, SQL Server, and more. Linux, MacOS, and Windows
    # beekeeper-studio

    # Universal SQL Client for developers, DBA and analysts. Supports MySQL, PostgreSQL, MariaDB, SQLite, and more
    dbeaver-bin

    # DB Browser for SQLite
    sqlitebrowser

    # mongodb
    mongodb-compass
    mongodb-cli
    mongodb-ce
    mongodb-tools
    mongodb-atlas-cli
    mongosh
  ];
}
