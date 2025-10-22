{ settings, pkgs, ... }: {
  # Free and source-available fair-code licensed workflow automation tool
  services.n8n.enable = true;
  environment.systemPackages = with pkgs; [ n8n ];
}
