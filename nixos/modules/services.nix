{ pkgs, ... }:
{
	services = {
		# Whether to enable periodic SSD TRIM of mounted partitions in background.
		# fstrim.enable = true;

		printing.enable = true; # Enable CUPS to print documents.
		openssh.enable = true; # Enable the OpenSSH daemon.
		flatpak.enable = true;
		sysprof.enable = true;

		# Enable touchpad support (enabled default in most desktopManager).
		libinput.mouse.accelSpeed = "-0.5";
		
		# systemd DNS resolver daemon, systemd-resolved.
		# resolved.enable = true;

		xserver = {
			# Enable the X11 windowing system.
			enable = true;
			excludePackages = [ pkgs.xterm ];
			# sysprof.enable = true;
			# printing.enable = true;
			# flatpak.enable = true;
			# openssh.enable = true;
			# Enable the GNOME Desktop Environment.
			displayManager = {
				gdm.enable = true;
				gdm.wayland = true;
				# autoLogin.enable = true;
				# autoLogin.user = "softeng";
			};
			desktopManager.gnome.enable = true;
			# Configure keymap in X11
			xkb = { layout = "us"; variant = ""; };
			videoDrivers = [ "amdgpu" ];
		};
		
		dnsmasq = {
			# Configure dnsmasq
			enable = true;
			settings = {
				# Set Google DNS for IPv4 and IPv6
				server = [
					"8.8.8.8"
					"8.8.4.4"
					"2001:4860:4860::8888"
					"2001:4860:4860::8844"
				];
			};
		};
		
		# logind
		logind.extraConfig = ''
			HandlePowerKey=ignore
			HandleLidSwitch=suspend
			HandleLidSwitchExternalPower=ignore
		'';

		#beesd = {
		#	enable = true;
		#	filesystems.btrfs = {
		#		# Example mount point for your Btrfs partition
		#		spec = "/mnt/btrfs";
		#		hashTableSizeMB = 1024; # 1GB hashtable size
		#	};
		#};
	};
}
