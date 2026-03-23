{ pkgs, ... }:
{
  services.postgresql = {
    enable = true;
    authentication = "";
  };

  # services.pgadmin.enable = true;
  # services.pgadmin.initialEmail =
  environment.systemPackages = with pkgs; [
    postgresql
    # pgadmin4
  ];
}
