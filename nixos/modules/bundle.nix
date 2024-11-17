{
	imports = [
		# Bootloader configuration
		./bootloader.nix
		
		# Audio settings
		./audio.nix
		
		# Zram configuration
		./zram.nix

		# Hardware-specific configurations
		./hardware.nix

		# Power management settings
		./powermanagement.nix

		# User environment (programs, services, etc.)
		./programs.nix
		./env.nix
		./fonts.nix
		./user.nix
		
		# X11 and window manager settings
		./xserver.nix
		./hyprland.nix

		# System services and security
		./security.nix
		./networking.nix
		./services.nix
		#./bluetooth.nix
		#./virtualisation.nix
		./nautilus.nix
		./locale.nix
		# ./laptop.nix
		./home.nix
		./gnome.nix

	];
}
