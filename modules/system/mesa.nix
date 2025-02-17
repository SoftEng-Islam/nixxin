{ settings, lib, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    mesa # An open source 3D graphics library
    mesa_glu # OpenGL utility library
    mesa_i686 # Open source 3D graphics library
    mesa-demos # Collection of demos and test programs for OpenGL and Mesa
  ];
}
