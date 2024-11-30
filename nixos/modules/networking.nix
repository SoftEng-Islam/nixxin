{
	networking = {
		networkmanager = {
			enable = true;
			wifi.powersave = false;
		};
		hostName = "nixos"; # Define your hostname.
		nftables.enable = true;
		dhcpcd.enable = false;
		useNetworkd = false;
		networkmanager.dns = "dnsmasq";
		firewall.enable = false;


		# wireless.enable = true;  # Enables wireless support via wpa_supplicant.
		# useNetworkd = true;
		# wireless.enable = true;


		firewall.extraCommands = ''
			iptables -t nat -A POSTROUTING -o wlan1 -j MASQUERADE
			iptables -A FORWARD -i wlan1 -o eno1 -m state --state RELATED,ESTABLISHED -j ACCEPT
			iptables -A FORWARD -i eno1 -o wlan1 -j ACCEPT
		'';

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
				# Provide DHCP settings (if applicable)
				dhcpRange = "10.42.0.10,10.42.0.100,12h";  # Adjust to your network
				dhcpLeaseTime = "12h";
			};
		};
}
