{ pkgs, ... }:
{
  services.postgresql.enable = true;
  services.pgadmin.enable = true;
  environment.systemPackages = with pkgs; [
    postgresql
    pgadmin4
  ];
}
