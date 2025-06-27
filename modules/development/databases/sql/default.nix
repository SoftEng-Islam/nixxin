{ settings, config, lib, pkgs, ... }:
let inherit (lib) mkIf;
in {
  config = mkIf (settings.modules.development.databases.sql.enable) {
    environment.systemPackages = with pkgs; [
      sql-formatter
      sql-studio
      sqlcheck
      sqlcipher
      sqlite
      sqlite-analyzer
    ];
  };
}
