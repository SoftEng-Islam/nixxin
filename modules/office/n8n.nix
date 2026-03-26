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
    environment = {
      # Port (default 5678)
      N8N_PORT = "5678"; # Coerced to string to avoid env var issues
      # Public URL for webhooks and OAuth callbacks (will be set by tunnel)
      N8N_PROTOCOL = "https";
      # Disable n8n authentication for tunnel access
      N8N_AUTH_EXCLUDE_ENDPOINTS = "*";
      # Enable executeCommand node (disabled by default in v2 for security)
      NODES_EXCLUDE = "[]";
      # Allow workflows to access env vars (for API keys via EnvironmentFile)
      N8N_BLOCK_ENV_ACCESS_IN_NODE = "false";

      # N8N_ENCRYPTION_KEY_FILE = "/run/n8n/encryption_key";
      # DB_POSTGRESDB_PASSWORD_FILE = "/run/n8n/db_postgresdb_password";

      # Use localtunnel for tunneling instead of n8n's built-in tunnel
      # The tunnel will be created by a separate localtunnel service
      # Set webhook URL to match the tunnel
      WEBHOOK_URL = "https://n8n-nixxin.loca.lt";
    };
  };

  # Localtunnel service for tunneling n8n
  systemd.services.localtunnel-n8n = {
    description = "Localtunnel for n8n";
    after = [
      "network.target"
      "n8n.service"
    ];
    wants = [ "n8n.service" ];
    serviceConfig = {
      ExecStart = "${pkgs.nodePackages.localtunnel}/bin/lt --port 5678 --subdomain n8n-nixxin";
      Restart = "on-failure";
      RestartSec = 5;
    };
  };

  environment.systemPackages = with pkgs; [
    n8n
    nodePackages.localtunnel
  ];
}
