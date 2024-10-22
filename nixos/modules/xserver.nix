{
	services.xserver = {
		# Enable the X11 windowing system.
		enable = true;
		# Enable the GNOME Desktop Environment.
		displayManager = {
			gdm.enable = true;
			# autoLogin.enable = true;
			# autoLogin.user = "softeng";
		};
		desktopManager.gnome.enable = true;
		# Configure keymap in X11
		xkb = { layout = "us"; variant = ""; };
		windowManager.herbstluftwm.enable = true;
		libinput = {
			enable = true;
			mouse.accelProfile = "flat";
			touchpad.accelProfile = "flat";
		};
		videoDrivers = [ "amdgpu" ];
		deviceSection = ''Option "TearFree" "True"'';
	};
}
