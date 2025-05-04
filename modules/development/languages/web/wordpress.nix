{ inputs, config, lib, pkgs, ... }:

let
  domain = "example.com";

  # Setting custom php.ini configurations
  _php = pkgs.php.buildEnv { extraConfig = "memory_limit = 2G"; };
in {
  imports = [ inputs.impermanence.nixosModules.impermanence ];
  networking.firewall.allowedTCPPorts = [ 80 443 ];

  services.httpd.enable = true;
  services.httpd.adminAddr = "webmaster@example.org";
  services.httpd.enablePHP = true; # oof... not a great idea in my opinion

  services.httpd.virtualHosts."example.org" = {
    documentRoot = "/var/www/example.org";
    # want ssl + a let's encrypt certificate? add `forceSSL = true;` right here
  };

  # services.mysql.enable = true;
  # services.mysql.package = pkgs.mariadb;

  # hacky way to create our directory structure and index page... don't actually use this
  systemd.tmpfiles.rules = [
    "d /var/www/example.org"
    "f /var/www/example.org/index.php - - - - <?php phpinfo();"
  ];

  # As this is a root on tmpfs system, we use the impermanence
  # NixOS module to persist WordPress state between reboots.
  # You can omit the next two lines if using a regular configuration.
  environment.persistence."/persist".directories =
    [ "/var/lib/mysql" "/var/lib/wordpress" ];

  environment.systemPackages = with pkgs; [ wordpress _php mysql84 nginx ];
}
