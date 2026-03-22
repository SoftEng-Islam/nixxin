{ pkgs, ... }:
{
  services.postgresql.enable = true;
  environment.systemPackages = with pkgs; [
    postgresql
    pgadmin
  ];
}
