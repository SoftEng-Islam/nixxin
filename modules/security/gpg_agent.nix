{ settings, ... }: {
  programs.gnupg.agent.settings = {
    default-cache-ttl = 14400;
    max-cache-ttl = 43200;
  };
}
