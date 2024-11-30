{
	programs = {
		zsh.enable = true;
		xwayland.enable = true;
		zsh.ohMyZsh.enable = true;

		corectrl.enable = true;
		corectrl.gpuOverclock.ppfeaturemask = "0xffffffff";
		corectrl.gpuOverclock.enable = true;
		

		# camera
		droidcam.enable = true;
		
		# dconf
		dconf.enable = true;
		
		mtr.enable = true;
		
		gnupg.agent = {
			enable = true;
			enableSSHSupport = true;
		};
	};
}
