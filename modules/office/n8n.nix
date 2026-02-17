{ settings, pkgs, ... }:
{
  # Free and source-available fair-code licensed workflow automation tool

  services.n8n = {
    enable = true;
    environment = {
      # N8N_PORT = "5678";
      # N8N_ENCRYPTION_KEY_FILE = "/run/n8n/encryption_key";
      # DB_POSTGRESDB_PASSWORD_FILE = "/run/n8n/db_postgresdb_password";
      # WEBHOOK_URL = "https://n8n.example.com";
    };
  };
  # systemd.services.n8n.serviceConfig.ProtectHome = "tmpfs";
  # systemd.services.n8n.serviceConfig.BindPaths = "/home/user/n8n";
  # environment.variables.N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS = "true";
  environment.systemPackages = with pkgs; [ n8n ];
}
