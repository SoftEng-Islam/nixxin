{ config, pkgs, lib, ... }:
let
  # php 8.1 is the easiest option - if you need  php 7.x then we can discuss https://github.com/fossar/nix-phps/ as an option
  php' = pkgs.php81.buildEnv {
    # any customizations to your `php.ini` go here
    extraConfig = ''
      memory_limit = 1024M
    '';
  };
in {
  networking.hosts = {
    # convenient if you're going to work on multiple sites
    "127.0.0.1" = [ "example.org" ];
  };

  services.mysql.enable = true;
  services.mysql.package = pkgs.mariadb;
  services.mysql.ensureDatabases = [
    # list a database for every site you want and they will be automatically created
    "example"
  ];
  services.mysql.ensureUsers = [
    # NOTE: it is important that `name` matches your `$USER` name, this allows us to avoid password authentication
    {
      name = "softeng";
      ensurePermissions = { "*.*" = "ALL PRIVILEGES"; };
    }
  ];

  services.phpfpm.pools."example.org" = {
    user = "softeng";
    group = "users";
    phpPackage = php';
    settings = {
      "listen.owner" = config.services.caddy.user;
      "listen.group" = config.services.caddy.group;
      "pm" = "dynamic";
      "pm.max_children" = 5;
      "pm.start_servers" = 2;
      "pm.min_spare_servers" = 1;
      "pm.max_spare_servers" = 5;
    };
  };

  services.caddy.enable = true;
  # we'll keep it simple and stick to plain http for now, though caddy supports https relatively easily
  services.caddy.virtualHosts."http://example.org:80".extraConfig = ''
    root * /var/www/example.org
    php_fastcgi unix/${config.services.phpfpm.pools."example.org".socket}
    file_server
  '';

  # automatically create a directory for each site you will work on with appropriate ownership+permissions
  systemd.tmpfiles.rules = [ "d /var/www/example.org 0755 softeng users" ];
}
