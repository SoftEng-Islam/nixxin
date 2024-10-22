{
	hardware.pulseaudio.enable = false;
	sound.enable = true; # Whether to enable ALSA sound.
	# rtkit is optional but recommended
	security.rtkit.enable = true; # Whether to enable the RealtimeKit system service
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
		# If you want to use JACK applications, uncomment this
		# jack.enable = true;

		# use the example session manager (no others are packaged yet so this is enabled by default,
		# no need to redefine it in your config for now)
		#media-session.enable = true;
	};
}
