{ settings, ... }:
{
  home-manager.users.${settings.user.username} = {
    programs.noctalia-shell.settings = {
      lockscreen = {
      };
    };
  };
}
