{ settings, ... }:
{
  home-manager.users.${settings.user.username} = {
    programs.noctalia.settings = {
      hooks = {
        enabled = true;
        # startup = "noctalia ipc call lockScreen lock";
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
