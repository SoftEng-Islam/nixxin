{ pkgs, ... }: {
	virtualisation = {
		podman.enable = true;
		docker.enable = true;
		libvirtd.enable = true;
	};
	programs.virt-manager = {
		enable = true;
		package = pkgs.virt-manager;
	};
}

