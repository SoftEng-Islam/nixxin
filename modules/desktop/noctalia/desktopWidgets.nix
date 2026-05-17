{ settings, ... }:
{
  home-manager.users.${settings.user.username} = {
    programs.noctalia.settings = {
      desktopWidgets = {
        enabled = false;
        gridSnap = false;
        monitorWidgets = [ ];
      };
    };
  };
}
