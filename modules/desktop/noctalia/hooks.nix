{ settings, ... }:
{
  home-manager.users.${settings.user.username} = {
    programs.noctalia-shell.settings = {
      hooks = {
        enabled = true;
        #startup = "noctalia-shell ipc call lockScreen lock";

        # wallpaperChange = "";
        # darkModeChange = "";
        screenLock = "noctalia-shell ipc call lockScreen lock";
        screenUnlock = "noctalia-shell ipc call lockScreen unlock";
        # performanceModeEnabled = "";
        # performanceModeDisabled = "";
        # session = "";
      };
    };
  };
}
