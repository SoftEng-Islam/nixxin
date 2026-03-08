{ settings, ... }:
{
  home-manager.users.${settings.user.username} = {
    programs.noctalia-shell.settings = {
      controlCenter = {
        position = "top_right";
        shortcuts = {
          left = [
            { id = "ScreenRecorder"; }
            { id = "KeepAwake"; }
            { id = "NightLight"; }
          ];
          right = [ ];
        };
        cards = [
          {
            enabled = true;
            id = "profile-card";
          }
          {
            enabled = false;
            id = "shortcuts-card";
          }
          {
            enabled = false;
            id = "audio-card";
          }
          {
            enabled = false;
            id = "weather-card";
          }
          {
            enabled = true;
            id = "media-sysmon-card";
          }
        ];
      };
    };
  };
}
