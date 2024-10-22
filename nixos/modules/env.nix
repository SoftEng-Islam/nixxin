{
	# Environment
	environment.memoryAllocator.provider = "jemalloc"; # The system-wide memory allocator.

	environment.variables = {
		EDITOR = "nvim";
		RANGER_LOAD_DEFAULT_RC = "FALSE";
		QT_QPA_PLATFORMTHEME = "qt5ct";
		GSETTINGS_BACKEND = "keyfile";
	};
}
