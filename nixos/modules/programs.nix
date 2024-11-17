{
	programs.zsh.enable = true;
	programs.xwayland.enable = true;
	programs.zsh.ohMyZsh.enable = true;

	# camera
	programs.droidcam.enable = true;
	
	# dconf
	programs.dconf.enable = true;
	
	programs.mtr.enable = true;
	
	programs.gnupg.agent = {
		enable = true;
		enableSSHSupport = true;
	};
}
