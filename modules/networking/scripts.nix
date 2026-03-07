{ settings, lib, pkgs, ... }:
lib.mkIf (settings.modules.networking.scripts) {

	  environment.systemPackages = with pkgs; [
	    # Disable Network Manager and Enter monitor mode
	    writeShellScriptBin
	    "monitor-mode-on"
	    ''
	      sudo modprobe -r rtl8xxxu
	      sudo modprobe 8188eu
	      if command -v nmcli > /dev/null 2>&1; then
	        sudo nmcli device set wlp0s22f2u4 managed no || true
	      fi
	      sudo ip link set wlp0s22f2u4 down
	      sudo iw dev wlp0s22f2u4 set type monitor
	    ''

	    # Disable monitor mode
	    writeShellScriptBin
	    "monitor-mode-off"
	    ''
	      sudo modprobe -r 8188eu
	      sudo modprobe rtl8xxxu
	      if command -v nmcli > /dev/null 2>&1; then
	        sudo nmcli device set wlp0s22f2u4 managed yes || true
	      fi
	      sudo ip link set wlp0s22f2u4 up
	      sudo iw dev wlp0s22f2u4 set type managed
	      sudo systemctl restart avahi-daemon.service
	      sudo systemctl restart NetworkManager.service
	    ''
	  ];
}
