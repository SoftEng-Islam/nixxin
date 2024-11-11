{
	networking = {
		networkmanager.enable = true;
		hostName = "nixos"; # Define your hostname.
	#	wireless.enable = true;  # Enables wireless support via wpa_supplicant.
	#	networkmanager.connections = [
	#	{
	#		type = "wifi";
	#		name = "M.Alaa";        # Replace with your Wi-Fi SSID
	#		uuid = "ce7928a8-eee3-4532-8c16-ed5850217ea6";          # Replace with a unique UUID for the connection
	#		options = {
	#			ssid = "M.Alaa"; # The SSID of the Wi-Fi network
	#			mode = "infrastructure";
	#			psk = "Admin@321";   # Replace with your Wi-Fi password
	#		};
	#	}
	#	];


		#useNetworkd = true;
		#wireless.enable = true;

		
		# Configure network proxy if necessary
		# proxy.default = "http://user:password@proxy:port/";
		# proxy.noProxy = "127.0.0.1,localhost,internal.domain";
		# Enable networking
		# Open ports in the firewall.
		# firewall.allowedTCPPorts = [ ... ];
		# firewall.allowedUDPPorts = [ ... ];
		# Or disable the firewall altogether.
		firewall.enable = false;
		# firewall.extraCommands = ''
		# iptables -t nat -A POSTROUTING -o wlp0s16f0u1 -j MASQUERADE
		# iptables -A FORWARD -i wlp0s16f0u1 -o eno1 -m state --state RELATED,ESTABLISHED -j ACCEPT
		# iptables -A FORWARD -i eno1 -o wlp0s16f0u1 -j ACCEPT
		# '';
		wireless.iwd = {
			enable = true;
			settings = {
				Network = {
					EnableIPv6 = true;
					RoutePriorityOffset = 300;
				};
				Settings = { AutoConnect = true; };
			};
		};
	};

}
