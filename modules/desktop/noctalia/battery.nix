{ settings, ... }:
{
  home-manager.users.${settings.user.username} = {
    programs.noctalia-shell.settings = {
      battery = {
        enabled = false;
        chargingMode = 0;
      };
    };
  };
}
