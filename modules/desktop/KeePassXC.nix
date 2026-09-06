{
  settings,
  lib,
  ...
}:
{
  home-manager.users."${settings.user.username}" = {
    xdg.autostart.enable = true;
    programs.keepassxc = {
      enable = true;
      autostart = true;
      settings = {
        General = {
          ConfigVersion = 2;
          LastActiveDatabase = "/home/${settings.user.username}/Documents/Passwords.kdbx";
        };
        Security = {
          LockDatabaseIdle = true;
          LockDatabaseIdleSeconds = 60;
        };
        Browser = {
          Enabled = true;
          SearchInAllDatabases = true;
          UpdateBinaryPath = false;
        };
        GUI = {
          AdvancedSettings = true;
          ApplicationTheme = "dark";
          MinimizeOnClose = true;
          MinimizeToTray = true;
          ShowTrayIcon = true;
        };
        SSHAgent.Enabled = true;
      };
    };
  };
}
