{
  settings,
  lib,
  pkgs,
  ...
}:
{
  home-manager.users."${settings.user.username}" = {
    xdg.configFile."keepassxc/keepassxc.ini".text = lib.generators.toINI { } {
      General.ConfigVersion = 2;
      Security = {
        LockDatabaseIdle = true;
        LockDatabaseIdleSeconds = 60;
      };
      Browser = {
        Enabled = true;
        SearchInAllDatabases = true;
      };
      GUI = {
        TrayIconAppearance = "monochrome-light";
      };
    };
    home.file.".cache/keepassxc/keepassxc.ini".text = lib.generators.toINI { } {
      General.LastActiveDatabase = "/home/gotlou/Documents/DB/database.kdbx";
    };
    home.packages = with pkgs; [ keepassxc ];
  };
}
