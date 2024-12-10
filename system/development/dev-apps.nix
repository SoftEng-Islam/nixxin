{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # __ Developers Applications __#
    beekeeper-studio # Modern and easy to use SQL client for MySQL, Postgres, SQLite, SQL Server, and more. Linux, MacOS, and Windows
    dbeaver-bin # Universal SQL Client for developers, DBA and analysts. Supports MySQL, PostgreSQL, MariaDB, SQLite, and more
    sqlitebrowser # DB Browser for SQLite
    bruno # Open-source IDE For exploring and testing APIs.
  ];
}
