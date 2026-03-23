{ pkgs, ... }:
{

  # services.pgadmin.enable = true;
  # services.pgadmin.initialEmail = "" ;
  environment.systemPackages = with pkgs; [
    postgresql
    # pgadmin4
  ];

  services.postgresql = {
    enable = true;
    authentication = "";
  };
}
