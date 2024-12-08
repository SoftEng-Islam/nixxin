{
	# Security
	security.allowSimultaneousMultithreading = true; # to allow SMT/hyperthreading
	security.sudo.extraConfig = "Defaults        env_reset,pwfeedback"; # show Password as stars in Terminals.
	#security.selinux = null;
	security.polkit.enable = true;
	#security.polkit.debug = true;
}
