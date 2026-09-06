{
  settings,
  lib,
  pkgs,
  ...
}:
{
  home-manager.users."${settings.user.username}" = {
    xdg.configFile."keepassxc/keepassxc.ini".text = lib.generators.toINI { } {
      General = {
        ConfigVersion = 2;
        LastActiveDatabase = "/home/${settings.user.username}/Documents/DB/database.kdbx";
      };
      Security = {
        LockDatabaseIdle = true;
        LockDatabaseIdleSeconds = 60;
      };
      Browser = {
        Enabled = true;
        SearchInAllDatabases = true;
      };
      GUI.TrayIconAppearance = "monochrome-light";
    };
    home.packages = with pkgs; [ keepassxc ];
  };
}
