{ pkgs, ... }:
{
  services.postgresql.enable = true;
  # services.pgadmin.enable = true;
  # services.pgadmin.initialEmail =
  environment.systemPackages = with pkgs; [
    postgresql
    # pgadmin4
  ];
}
