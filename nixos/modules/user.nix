{ pkgs, ... }: {
	users = {
		defaultUserShell = pkgs.zsh;
		users.softeng = {
			isNormalUser = true;
			description = "softeng";
			# shell = pkgs.zsh; # Set zsh as the default shell
			extraGroups = [ "networkmanager" "wheel" "input" "flatpak" "disk" "qemu" "kvm" "i2c" "libvirtd" "sshd" "networkmanager" "wheel" "audio" "video" "root" ];
			packages = with pkgs; [
				#  thunderbird
			];
			};
		};
	# Enable automatic login for the user.
	# services.getty.autologinUser = "softeng";
}
