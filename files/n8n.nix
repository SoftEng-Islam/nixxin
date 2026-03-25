{
  pkgs,
  config,
  lib,
  ...
}:
{
  services.n8n = {
    enable = true;
    environment = {
      # Port (default 5678)
      N8N_PORT = 5678;
      # Public URL for webhooks and OAuth callbacks
      N8N_PROTOCOL = "https";
      # Bypass n8n's built-in auth - Cloudflare Access handles authentication
      N8N_AUTH_EXCLUDE_ENDPOINTS = "*";
      # Trust proxy headers from Cloudflare
      N8N_TRUST_PROXY = "true";
      # Enable executeCommand node (disabled by default in v2 for security)
      NODES_EXCLUDE = "[]";
      # Allow workflows to access env vars (for API keys via EnvironmentFile)
      N8N_BLOCK_ENV_ACCESS_IN_NODE = "false";
    };
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
      EnvironmentFile = [
        config.age.secrets."n8n-anthropic-api-key".path
        config.age.secrets."n8n-ntfy-url".path
        config.age.secrets."n8n-user-bio".path
      ];
    };
  };

}
