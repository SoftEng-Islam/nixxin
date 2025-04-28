{ settings, config, lib, pkgs, ... }:
let inherit (lib) mkIf;
in {
  config = mkIf (settings.modules.development.databases.mysql.enable) {
    services.mysql = {
      enable = true;
      package = pkgs.mysql84;
    };
    environment.systemPackages = with pkgs; [ mysql84 mariadb ];
  };
}
