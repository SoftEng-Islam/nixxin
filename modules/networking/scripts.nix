{ settings, lib, pkgs, ... }:
lib.mkIf (settings.modules.networking.scripts) {

  environment.systemPackages = with pkgs; [
    # Disable Network Manager and Enter monitor mode
    writeShellScriptBin
    "monitor-mode-on"
    ''
      sudo airmon-ng check kill
      sudo ip link set wlp0s22f2u4 down
      sudo iw dev wlp0s22f2u4 set type monitor
    ''

    # Disable Network Manager and Enter monitor mode
    writeShellScriptBin
    "monitor-mode-off"
    ''
      sudo airmon-ng stop wlp0s22f2u4
      sudo ip link set wlp0s22f2u4 up
      sudo iw dev wlp0s22f2u4 set type managed
      sudo systemctl restart avahi-daemon.service
      sudo systemctl restart NetworkManager.service
    ''
  ];
}
