{
	# Some programs need SUID wrappers, can be configured further or are
	# started in user sessions.
	# programs.mtr.enable = true;
	# programs.gnupg.agent = {
	#   enable = true;
	#   enableSSHSupport = true;
	# };
	# programs.corectrl.gpuOverclock.ppfeaturemask = "0xffffffff";
	# programs.steam.enable = true;
	# programs.steam.gamescopeSession.enable = true;
	# programs.gamemode.enable = true;
	# programs.corectrl.enable = true; # a tool to overclock amd graphics cards and processors. 
	#programs.zsh.syntaxHighlighting.enable = true;
	#programs.zsh.autosuggestions.enable = true;
	#programs.zsh.enableCompletion = true;
	#programs.zsh.enableLsColors = true;
	#programs.fzf.fuzzyCompletion = true;
	programs.zsh = {
		enable = true;
		ohMyZsh.enable = true;
		ohMyZsh.plugins = [
		# "git"
		# "zsh-git-prompt"
		# "fzf-zsh"
		# "zsh-fzf-tab"
		# "zsh-completions"
		# "zsh-autocomplete"
		# "zsh-autosuggestions"
		# "zsh-syntax-highlighting"
		];
	};
}