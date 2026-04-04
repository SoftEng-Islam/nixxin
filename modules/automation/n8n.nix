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
      DB_TYPE = "sqlite";
      DB_SQLITE_POOL_SIZE = "5";

      # Network configuration
      N8N_HOST = "127.0.0.1";
      N8N_PORT = "5678";
      N8N_PROTOCOL = "https";

      # Webhook configuration - using localhost for OAuth compatibility
      WEBHOOK_URL = "https://localhost";

      # Security - disable metrics endpoint
      N8N_METRICS = "false";

      # Enable the task runner process (deprecated to keep it false)
      N8N_RUNNERS_ENABLED = "true";
      N8N_VERSION_NOTIFICATIONS_ENABLED = "false";
      N8N_DIAGNOSTICS_ENABLED = "false";
    };
  };

  # Configure n8n service to use our static user instead of DynamicUser
  systemd.services.n8n = {
    wantedBy = lib.mkForce [ ]; # Removes it from the default startup list

    # Add nodejs to PATH for task runner child processes (Code nodes)
    path = [ pkgs.nodejs ];
    serviceConfig = {
      User = "n8n";
      Group = "n8n";
      DynamicUser = lib.mkForce false;
      ReadWritePaths = [ "/var/lib/n8n" ];
      # Allow n8n to read/write the obsidian vault via executeCommand nodes
      ProtectHome = lib.mkForce false;
      ProtectSystem = lib.mkForce "full";
      PrivateTmp = lib.mkForce false;
    };
  };

  # MongoDB is no longer supported and n8n-db-setup has been removed.

  # Create n8n user for the service
  users.users.n8n = {
    isSystemUser = true;
    group = "n8n";
    home = "/var/lib/n8n";
    createHome = true;
  };

  users.groups.n8n = { };

  # Nginx reverse proxy with HTTPS
  services.nginx = {
    enable = true;

    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts."${config.networking.hostName}.local" = {
      forceSSL = true;
      sslCertificate = "/persist/ssl/${config.networking.hostName}.local.crt";
      sslCertificateKey = "/persist/ssl/${config.networking.hostName}.local.key";

      locations."/" = {
        proxyPass = "http://127.0.0.1:5678";
        proxyWebsockets = true;
        extraConfig = ''
          proxy_set_header Host $host;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header X-Forwarded-Proto $scheme;
        '';
      };
    };

    # Localhost virtualHost for OAuth callbacks (Desktop App credentials)
    virtualHosts."localhost" = {
      forceSSL = true;
      sslCertificate = "/persist/ssl/localhost.crt";
      sslCertificateKey = "/persist/ssl/localhost.key";

      locations."/" = {
        proxyPass = "http://127.0.0.1:5678";
        proxyWebsockets = true;
        extraConfig = ''
          proxy_set_header Host $host;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header X-Forwarded-Proto $scheme;
        '';
      };
    };
  };

  # Open HTTPS port
  networking.firewall.allowedTCPPorts = [ 443 ];

  # Persistence for n8n data
  # environment.persistence."/persist" = {
  #   directories = [
  #     {
  #       directory = "/var/lib/n8n";
  #       user = "n8n";
  #       group = "n8n";
  #       mode = "0700";
  #     }
  #   ];
  # };

  # Script to generate self-signed certificate if it doesn't exist
  systemd.services.n8n-ssl-setup = {
    description = "Generate self-signed SSL certificates for n8n";
    wantedBy = [ "multi-user.target" ];
    before = [ "nginx.service" ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };

    script = ''
      CERT_DIR="/persist/ssl"

      mkdir -p "$CERT_DIR"

      # Generate certificate for hostname.local
      CERT_FILE="$CERT_DIR/${config.networking.hostName}.local.crt"
      KEY_FILE="$CERT_DIR/${config.networking.hostName}.local.key"

      if [ ! -f "$CERT_FILE" ] || [ ! -f "$KEY_FILE" ]; then
        echo "Generating self-signed certificate for ${config.networking.hostName}.local..."
        ${pkgs.openssl}/bin/openssl req -x509 -nodes -days 3650 -newkey rsa:2048 \
          -keyout "$KEY_FILE" \
          -out "$CERT_FILE" \
          -subj "/C=US/ST=State/L=City/O=Organization/CN=${config.networking.hostName}.local"

        chmod 640 "$KEY_FILE"
        chgrp nginx "$KEY_FILE" 2>/dev/null || true
        chmod 644 "$CERT_FILE"
        echo "Certificate for ${config.networking.hostName}.local generated successfully!"
      else
        echo "SSL certificate for ${config.networking.hostName}.local already exists. Fixing permissions..."
        chmod 640 "$KEY_FILE"
        chgrp nginx "$KEY_FILE" 2>/dev/null || true
        chmod 644 "$CERT_FILE"
      fi

      # Generate certificate for localhost (for OAuth callbacks)
      LOCALHOST_CERT_FILE="$CERT_DIR/localhost.crt"
      LOCALHOST_KEY_FILE="$CERT_DIR/localhost.key"

      if [ ! -f "$LOCALHOST_CERT_FILE" ] || [ ! -f "$LOCALHOST_KEY_FILE" ]; then
        echo "Generating self-signed certificate for localhost..."
        ${pkgs.openssl}/bin/openssl req -x509 -nodes -days 3650 -newkey rsa:2048 \
          -keyout "$LOCALHOST_KEY_FILE" \
          -out "$LOCALHOST_CERT_FILE" \
          -subj "/C=US/ST=State/L=City/O=Organization/CN=localhost"

        chmod 640 "$LOCALHOST_KEY_FILE"
        chgrp nginx "$LOCALHOST_KEY_FILE" 2>/dev/null || true
        chmod 644 "$LOCALHOST_CERT_FILE"
        echo "Certificate for localhost generated successfully!"
      else
        echo "SSL certificate for localhost already exists. Fixing permissions..."
        chmod 640 "$LOCALHOST_KEY_FILE"
        chgrp nginx "$LOCALHOST_KEY_FILE" 2>/dev/null || true
        chmod 644 "$LOCALHOST_CERT_FILE"
      fi
    '';
  };
  environment.systemPackages = with pkgs; [
    n8n
  ];
}
