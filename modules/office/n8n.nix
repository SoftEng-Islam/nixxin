{ settings, pkgs, ... }: {
  # Free and source-available fair-code licensed workflow automation tool

  services.n8n = {
    enable = true;
    settings = { };
  };
  systemd.services.n8n.serviceConfig.ProtectHome = "tmpfs";
  systemd.services.n8n.serviceConfig.BindPaths = "/home/user/n8n";
  environment.variables.N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS = "true";
  environment.systemPackages = with pkgs; [ n8n ];
}
