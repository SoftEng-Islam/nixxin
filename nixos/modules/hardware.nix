{pkgs, ...}: {
	# Hardware Options
	hardware = {
		enableAllFirmware = true;
		amdgpu.amdvlk.enable = true;
		amdgpu.amdvlk.support32Bit.enable = true;
		amdgpu.amdvlk.supportExperimental.enable = true;
		amdgpu.initrd.enable = true;
		amdgpu.legacySupport.enable = true; # Whether to enable using amdgpu kernel driver instead of radeon for Southern Islands (Radeon HD 7000) series and Sea Islands (Radeon HD 8000) series cards. Note: this removes support for analog video outputs, which is only available in the radeon driver .
		amdgpu.opencl.enable = true;
		graphics.enable = true;
		# pulseaudio.enable = false; # Enable sound with pipewire.
		# pulseaudio.support32Bit = false;
	};
}