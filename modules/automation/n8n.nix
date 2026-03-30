{
  settings,
  lib,
  config,
  pkgs,
  ...
}:
lib.mkIf (settings.modules.office.n8n or false) {
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

  # Configure n8n service to use our static user instead of DynamicUser
  systemd.services.n8n = {
    # Add nodejs to PATH for task runner child processes (Code nodes)
    path = [ pkgs.nodejs ];
    serviceConfig = {
      # User = "n8n";
      # Group = "n8n";
      DynamicUser = lib.mkForce false;
      # Allow n8n to read/write the obsidian vault via executeCommand nodes
      ProtectHome = lib.mkForce false;
      ProtectSystem = lib.mkForce "full";
      PrivateTmp = lib.mkForce false;
    };
  };

  services.n8n = {
    enable = true;
    # openFirewall = false; # We'll use nginx instead
    environment = {
      # Disable n8n authentication for tunnel access
      N8N_AUTH_EXCLUDE_ENDPOINTS = "*";
      # Enable executeCommand node (disabled by default in v2 for security)
      NODES_EXCLUDE = "[]";
      # Allow workflows to access env vars (for API keys via EnvironmentFile)
      N8N_BLOCK_ENV_ACCESS_IN_NODE = "false";

      # N8N_ENCRYPTION_KEY_FILE = "/run/n8n/encryption_key";
      # DB_POSTGRESDB_PASSWORD_FILE = "/run/n8n/db_postgresdb_password";

      # Database configuration
      DB_TYPE = "mongodb";

      # Network configuration
      N8N_HOST = "127.0.0.1";
      N8N_PORT = "5678";
      N8N_PROTOCOL = "https";

      # Webhook configuration - using localhost for OAuth compatibility
      WEBHOOK_URL = "https://localhost";

      # Security - disable metrics endpoint
      N8N_METRICS = "false";

      # Disable the task runner process
      N8N_RUNNERS_ENABLED = "false";
    };
  };

  environment.systemPackages = with pkgs; [
    n8n
  ];
}
