{ inputs, lib, pkgs, ... }:
let username = "softeng";

{
	users = {
		defaultUserShell = pkgs.zsh;
		users.${username} = {
			isNormalUser = true;
			description = "NixOs Admin";
			# shell = pkgs.zsh; # Set zsh as the default shell
			extraGroups = [ "root" "wheel" "input" "audio" "video" "i2c" "disk" "sshd" "flatpak" "networkmanager" "qemu" "kvm" "libvirtd" ];
			packages = with pkgs; [
				thunderbird
			];
		};
	};
	# services.getty.autologinUser = ${username}; # Enable automatic login for the user.
}
