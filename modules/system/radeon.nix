{ settings, config, lib, pkgs, ... }:

let
  inherit (lib) mkIf;
  vaapiSupport = pkgs.libva.override { withVaapi = true; };
in mkIf (settings.modules.system.radeon or false) {

  hardware.graphics.extraPackages = with pkgs; [
    mesa
    mesa_glu
    mesa-gl-headers
    libva
    libva-utils
    libva-vdpau-driver
    vulkan-loader
    vulkan-tools
    vulkan-headers
    vdpauinfo
  ];
  hardware.graphics.extraPackages32 = with pkgs.pkgsi686Linux; [
    intel-media-driver
    intel-vaapi-driver
    mesa_i686
  ];

  environment.systemPackages = with pkgs; [
    radeon-profile
    radeontop
    radeontools
  ];

  environment.variables = {
    LIBVA_DRIVER_NAME = "radeonsi"; # or "r600"; # Specific driver for HD 7470
    VDPAU_DRIVER = "radeonsi"; # or "va_gl"; # Use VA-API backend for VDPAU
  };

  # Optional: Force software acceleration for unsupported codecs
  # nixpkgs.config.packageOverrides = pkgs: { ffmpeg = pkgs.ffmpeg-full; };
}
