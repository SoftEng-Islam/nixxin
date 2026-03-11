{
  settings,
  lib,
  pkgs,
  ...
}:
lib.mkIf (settings.modules.office.n8n) {
  # [n8n] Free and source-available fair-code licensed workflow automation tool
  environment.variables = {
    # https://docs.n8n.io/hosting/configuration/environment-variables/security/

    # 1. Disable n8n's internal file blocks (values must be strings)
    N8N_BLOCK_FS_WRITE_ACCESS = "false";
    N8N_BLOCK_FS_READ_ACCESS = "false";

    # 2. Remove the path restriction (n8n v2 default is restricted)
    N8N_RESTRICT_FILE_ACCESS_TO = "";

    N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS = "true";
  };

  # Lift the NixOS/Systemd hardening so n8n can actually "see" /home
  systemd.services.n8n.serviceConfig = {
    ProtectHome = "false"; # Allows access to /home
    # ProtectHome = "tmpfs";
    # BindPaths = "/home/user/n8n";

    # Optional: If you want to be more secure, use this instead of ProtectHome=false:
    # ReadWritePaths = [ "/home/youruser/my_bot_folder" ];
  };

  services.n8n = {
    enable = true;
    environment = {
      # N8N_PORT = "5678";
      # N8N_ENCRYPTION_KEY_FILE = "/run/n8n/encryption_key";
      # DB_POSTGRESDB_PASSWORD_FILE = "/run/n8n/db_postgresdb_password";
      # WEBHOOK_URL = "https://n8n.example.com";
    };
  };
}
