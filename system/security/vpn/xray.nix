{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    xorg.xhost # start with sudo
    nekoray # Qt based cross-platform GUI proxy configuration manager
  ];
}
