{ settings, lib, pkgs, ... }:
let
  inherit (lib) optionals optional;
  _graphics_pkgs = settings.modules.graphics;
  _graphics = with pkgs; [
    (optional _graphics_pkgs.blender blender)
    (optional _graphics_pkgs.darktable darktable)
    (optional _graphics_pkgs.drawio drawio)
    (optional _graphics_pkgs.figmaLinux figma-linux)
    (optional _graphics_pkgs.gimp gimp)
    (optional _graphics_pkgs.inkscape inkscape)
    (optional _graphics_pkgs.lunacy lunacy)
    (optional _graphics_pkgs.kolourpaint kolourpaint)
  ];
in {
  imports = optionals (settings.modules.graphics.enable or false) [
    ./mesa.nix
    ./openGL.nix
    ./vulkan.nix
    ./nixos-opencl.nix
  ];
  config = lib.mkIf (settings.modules.graphics.enable or false) {

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      # Use unstable Mesa for better performance with latest Hyprland
      package = pkgs.mesa;
      package32 = pkgs.pkgsi686Linux.mesa;
      # Note: amdvlk has been deprecated, RADV is now the default driver
      extraPackages = with pkgs; [
        # amdvlk removed - RADV is now the default AMD Vulkan driver
        libva # Video acceleration API
        libvdpau-va-gl # VDPAU backend for video acceleration

        vulkan-memory-allocator
        vulkan-extension-layer
        vulkan-loader
        vulkan-tools
        libclc
        libGL
        libGLU
        libglvnd
        libGLX
        libvdpau
        libva-utils
        libva-vdpau-driver
        vdpauinfo
        xorg.libXv
        xorg.libXvMC
      ];
    };

    environment.systemPackages = with pkgs;
      [
        imagemagick
        jpegoptim
        optipng
        pngquant
        webp-pixbuf-loader
        libwebp
        libdrm # Direct Rendering Manager library and headers
        xorg.xf86videoamdgpu
        meshoptimizer
      ] ++ lib.flatten _graphics;
  };
}
