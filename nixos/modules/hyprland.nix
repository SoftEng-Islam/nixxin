{
	# Set Hyprland as the default session
	services.displayManager.defaultSession = "hyprland";
	programs.hyprland.xwayland.enable = true; # Whether to enable XWayland.
	programs.hyprland.enable = true;
	services.hypridle.enable = false; # Whether to enable hypridle, Hyprland’s idle daemon.
	programs.hyprlock.enable = false; # Whether to enable hyprlock, Hyprland’s GPU-accelerated screen locking utility.

}
