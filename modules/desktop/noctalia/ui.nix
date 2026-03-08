{ settings, lib, ... }:
{
  home-manager.users.${settings.user.username} = {
    programs.noctalia-shell.settings = {
      ui = {
        fontDefault = settings.common.mainFont.name;
        fontFixed = lib.mkForce settings.modules.fonts.monospace.name;
        idleInhibitorEnabled = true;
        tooltipsEnabled = true;
        fontDefaultScale = 1;
        fontFixedScale = 1;
        panelBackgroundOpacity = 1;
        panelsAttachedToBar = true;
        settingsPanelMode = "attached";
        wifiDetailsViewMode = "grid";
        bluetoothDetailsViewMode = "grid";
        networkPanelView = "wifi";
        bluetoothHideUnnamedDevices = false;
        boxBorderEnabled = false;
      };
    };
  };
}
