{
	# Bootloader Configuration:
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	boot.initrd.kernelModules = [ "amdgpu" ];
	# boot.kernelModules = [ "amdgpu" ];
	# boot.kernelParams = [ "psmouse.synaptics_intertouch=0" ]; 
	boot.kernelParams = [
		"amdgpu.gpu_recovery=1"
		"amdgpu.dc=1"
		"amdgpu.dpm=1"
		"radeon.si_support=0"
		"radeon.cik_support=0"
		"amdgpu.si_support=1"
		"amdgpu.cik_support=1"
		"nopat"
		"mitigations=off"
	];

	boot.kernel.sysctl = {
		"net.ipv4.ip_forward" = true; # Enable IPv4 forwarding
		"net.ipv6.conf.all.forwarding" = true;  # Enable IPv6 forwarding
		"vm.swappiness" = 60;
		"net.core.rmem_max" = 16777216;
		"net.core.wmem_max" = 16777216;
	};
}
