{ inputs, lib, pkgs, ... }: {
	users = {
		defaultUserShell = pkgs.zsh;
		users.softeng= {
			isNormalUser = true;
			description = "Nixos Admin";
			# shell = pkgs.zsh; # Set zsh as the default shell
			extraGroups = [ "root" "wheel" "input" "audio" "render" "video" "i2c" "disk" "sshd" "flatpak" "networkmanager" "qemu" "kvm" "libvirtd" ];
			packages = with pkgs; [
				thunderbird
			];
		};
	};
	# services.getty.autologinUser = "softeng"; # Enable automatic login for the user.
}
