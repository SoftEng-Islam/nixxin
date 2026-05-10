{ settings, pkgs, ... }:
{
  services.redis.servers."" = {
    enable = settings.modules.development.databases.redis.enable;
  };

  environment.systemPackages = with pkgs; [
    redis
    redisinsight
  ];
}
