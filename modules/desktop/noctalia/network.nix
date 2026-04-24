{ settings, ... }:
{
  home-manager.users.${settings.user.username} = {
    programs.noctalia-shell.settings = {
      network = {
        wifiEnabled = true;
        bluetoothRssiPollingEnabled = false;
        bluetoothRssiPollIntervalMs = 10000;
        wifiDetailsViewMode = "grid";
        bluetoothDetailsViewMode = "grid";
        bluetoothHideUnnamedDevices = false;
      };
    };
  };
}
