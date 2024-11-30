{pkgs, ...}: {
	hardware.pulseaudio.enable = false;
	# sound.enable = true; # Whether to enable ALSA sound.
	# rtkit is optional but recommended
	security.rtkit.enable = true; # Whether to enable the RealtimeKit system service
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
		jack.enable = true;
		wireplumber.enable = true;
		# extraConfig.pipewire."92-low-latency" = {
		# 	"context.properties" = {
		# 		"default.clock.rate" = 44100;
		# 		"default.clock.quantum" = 512;
		# 		"default.clock.min-quantum" = 512;
		# 		"default.clock.max-quantum" = 512;
		# 	};
		# };
		# use the example session manager (no others are packaged yet so this is enabled by default,
		# no need to redefine it in your config for now)
		#media-session.enable = true;
	};

		services.udev.extraRules = ''
		KERNEL=="rtc0", GROUP="audio"
		KERNEL=="hpet", GROUP="audio"
	'';

	security.pam.loginLimits = [
		{
		domain = "@audio";
		item = "memlock";
		type = "-";
		value = "unlimited";
		}
		{
		domain = "@audio";
		item = "rtprio";
		type = "-";
		value = "99";
		}
		{
		domain = "@audio";
		item = "nofile";
		type = "soft";
		value = "99999";
		}
		{
		domain = "@audio";
		item = "nofile";
		type = "hard";
		value = "524288";
		}
	];
}
