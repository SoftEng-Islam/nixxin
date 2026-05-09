{ settings, pkgs, ... }:
{
  services.mongodb.enable = settings.modules.development.databases.mongodb.enable;
  systemd.services.mongodb.serviceConfig.LimitNOFILE = 64000;

  environment.systemPackages = with pkgs; [
    # mongodb
    mongodb-compass
    mongodb-cli
    mongodb-ce
    mongodb-tools
    mongodb-atlas-cli
    mongosh
  ];
}
