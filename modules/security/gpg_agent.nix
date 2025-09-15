{ settings, ... }: {
  security.pam.services.${settings.user.username} = { enable = true; };
  programs.gnupg.agent.settings = {
    default-cache-ttl = 14400;
    max-cache-ttl = 43200;
  };
}
