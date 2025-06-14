{ settings, lib, config, pkgs, ... }: {
  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 14400;
    maxCacheTtl = 43200;
  };
}
