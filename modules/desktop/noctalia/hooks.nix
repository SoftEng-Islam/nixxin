{ settings, ... }:
{
  home-manager.users.${settings.user.username} = {
    programs.noctalia-shell.settings = {
      hooks = {
        enabled = true;
        startup = "noctalia-shell ipc call lockScreen lock";

        # wallpaperChange = "";
        # darkModeChange = "";
        # screenLock = "";
        # screenUnlock = "";
        # performanceModeEnabled = "";
        # performanceModeDisabled = "";
        # session = "";
      };
    };
  };
}
