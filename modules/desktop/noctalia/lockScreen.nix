{ settings, ... }:
{
  home-manager.users.${settings.user.username} = {
    programs.noctalia.settings = {
      lockscreen = {
      };
    };
  };
}
