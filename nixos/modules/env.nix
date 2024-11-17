{
	# Environment
	environment = {
		#memoryAllocator.provider = "jemalloc"; # The system-wide memory allocator.
		variables = {
			#EDITOR = "nvim";
			#RANGER_LOAD_DEFAULT_RC = "FALSE";
			#QT_QPA_PLATFORMTHEME = "qt5ct";
			#GSETTINGS_BACKEND = "keyfile";
			MOZ_ENABLE_WAYLAND = "1";  # Ensure Firefox works well on Wayland
			GTK_USE_PORTAL = "1";  # Enables portal-based access for apps like VSCode on Wayland
		};
		# Optional, hint electron apps to use wayland:
		#sessionVariables.NIXOS_OZONE_WL = "1";
	};
}
