{
	# Environment
	environment = {
		memoryAllocator.provider = "jemalloc"; # The system-wide memory allocator.
		variables = {
			EDITOR = "nvim";
			RANGER_LOAD_DEFAULT_RC = "FALSE";
			QT_QPA_PLATFORMTHEME = "qt5ct";
			GSETTINGS_BACKEND = "keyfile";
		};
		# Optional, hint electron apps to use wayland:
		sessionVariables.NIXOS_OZONE_WL = "1";
	};
}