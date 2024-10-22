{
	hardware.bluetooth = {
		enable = false;
		powerOnBoot = true;
		settings = {
			General = {
				Enable = "Source,Sink,Media,Socket";
				Experimental = true;
			};
		};
	};
	services.blueman.enable = false;
}
