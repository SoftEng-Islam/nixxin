{
	imports = [
		# Bootloader configuration
		./bootloader.nix
		
		# Sound settings
		./sound.nix
		
		# Zram configuration
		./zram.nix

		# Hardware-specific configurations
		./hardware.nix

		# Power management settings
		./powermanagement.nix

		# User environment (programs, services, etc.)
		./env.nix
		./fonts.nix
		./user.nix
		
		# X11 and window manager settings
		./xserver.nix
		./hyprland.nix

		# System services and security
		./security.nix
		./networkmanager.nix
		./services.nix
		./bluetooth.nix
		./virtmanager.nix

		# NixVim setup
		./nixvim/nixvim.nix
	]
}