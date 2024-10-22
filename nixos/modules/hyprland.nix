{
	programs.hyprland.enable = true;

	# Optional, hint electron apps to use wayland:
	environment.sessionVariables.NIXOS_OZONE_WL = "1";
	services.hypridle.enable = false; # Whether to enable hypridle, Hyprland’s idle daemon.
	programs.hyprlock.enable = false; # Whether to enable hyprlock, Hyprland’s GPU-accelerated screen locking utility.
	programs.uwsm.enable = true;
	programs.hyprland.xwayland.enable = true; # Whether to enable XWayland.
}
