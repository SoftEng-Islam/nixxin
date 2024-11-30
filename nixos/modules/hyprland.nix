{ pkgs, config, lib, ...}:
{
	programs = {
		hyprland.enable = true;
		hyprlock.enable = false; # Whether to enable hyprlock, Hyprland’s GPU-accelerated screen locking utility.
		hyprland.xwayland.enable = true; # Whether to enable XWayland.
		hyprland.withUWSM = true;
		uwsm.enable = true;
	};
	security = {
		polkit.enable = true;
		pam.services.astal-auth = {};
	};
	systemd = {
		user.services.polkit-gnome-authentication-agent-1 = {
			description = "polkit-gnome-authentication-agent-1";
			wantedBy = ["graphical-session.target"];
			wants = ["graphical-session.target"];
			after = ["graphical-session.target"];
			serviceConfig = {
			Type = "simple";
			ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
			Restart = "on-failure";
			RestartSec = 1;
			TimeoutStopSec = 10;
			};
		};
	};
}
