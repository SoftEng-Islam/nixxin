{
  settings,
  pkgs,
  lib,
  ...
}:
let
  dbUser = settings.user.username;
in
{
  # services.pgadmin.enable = true;
  # services.pgadmin.initialEmail = "" ;
  environment.systemPackages = with pkgs; [
    postgresql
    # pgadmin4
  ];

  services.postgresql = {
    enable = true;
    enableTCPIP = true;
    ensureDatabases = [ dbUser ];
    ensureUsers = [
      {
        name = dbUser;
        ensureDBOwnership = true;
        ensureClauses = {
          login = true;
          createdb = true;
        };
      }
    ];
    authentication = lib.mkForce ''
      # Local development only.
      local all all trust
      host all all 127.0.0.1/32 trust
      host all all ::1/128 trust
    '';
    settings = {
      listen_addresses = "127.0.0.1,::1";
    };
  };
}
