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

      # Use Cloudflare Tunnel for tunneling instead of n8n's built-in tunnel to allow Twitter API OAuth
      # The tunnel will be created by a separate cloudflared service below.
      # Set WEBHOOK_URL to match the Cloudflare domain where n8n is exposed.
      # Replace 'yourdomain.com' with your actual Cloudflare domain.
      WEBHOOK_URL = "https://n8n.nixxin.com";
    };
  };

  # Configure sops-nix to decrypt the Cloudflare token
  sops.age.keyFile = "/home/softeng/.config/sops/age/keys.txt";
  sops.secrets."cloudflared_token" = {
    sopsFile = ../../secrets/n8n.yaml;
    owner = "cloudflared";
  };

  # services.cloudflared = {
  #   enable = true;
  #   tunnels = {};
  # };

  # Cloudflare Tunnel service for n8n
  systemd.services.cloudflared-n8n = {
    description = "Cloudflare Tunnel for n8n";
    wantedBy = [ "multi-user.target" ];
    after = [
      "network-online.target"
      "n8n.service"
    ];
    wants = [ "network-online.target" ];
    environment = {
      TUNNEL_TOKEN_FILE = config.sops.secrets."cloudflared_token".path;
    };
    serviceConfig = {
      Type = "simple";
      User = "cloudflared";
      Group = "cloudflared";
      ExecStart = "${pkgs.cloudflared}/bin/cloudflared tunnel run";
      Restart = "on-failure";
      RestartSec = "5s";
      NoNewPrivileges = true;
      PrivateTmp = true;
      ProtectSystem = "strict";
      ProtectHome = true;
      ReadWritePaths = [ "/var/lib/cloudflared" ];
    };
  };

  # Create the cloudflared user
  users.users.cloudflared = {
    isSystemUser = true;
    group = "cloudflared";
    home = "/var/lib/cloudflared";
    createHome = true;
  };
  users.groups.cloudflared = {};

  environment.systemPackages = with pkgs; [
    n8n
    cloudflared
  ];
}
