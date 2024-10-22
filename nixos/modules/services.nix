{
	# Whether to enable periodic SSD TRIM of mounted partitions in background.
	# services.fstrim.enable = true;

	# Enable CUPS to print documents.
	services.printing.enable = true;

	# Enable touchpad support (enabled default in most desktopManager).
	# services.xserver.libinput.enable = true;
	services.libinput.mouse.accelSpeed = "-0.5";

	# List services:
	services.resolved.enable = false; # systemd DNS resolver daemon, systemd-resolved.
	services.dnsmasq = {
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

	# Enable the OpenSSH daemon.
	services.openssh.enable = true;
	services.xserver.videoDrivers = [ "amdgpu" ];


	# services.beesd.enable = true;
	# services.beesd.filesystems = {
	#   root = {
	#     spec = "LABEL=root";
	#     hashTableSizeMB = 2048;
	#     verbosity = "crit";
	#     extraOptions = [ "--loadavg-target" "5.0" ];
	#   };
	# }
	services.beesd = {
		enable = true;
		filesystems.btrfs = {
			# Example mount point for your Btrfs partition
			spec = "/mnt/btrfs";
			hashTableSizeMB = 1024; # 1GB hashtable size
		};
	};


}
