{ settings, config, lib, pkgs, ... }:

let
  inherit (lib) mkIf;
  vaapiSupport = pkgs.libva.override { withVaapi = true; };
in mkIf (settings.modules.system.radeon or false) {
  environment.systemPackages = with pkgs; [
    mesa
    mesa.drivers
    libva
    libva-utils
    vaapiVdpau
    libvdpau-va-gl
    vdpauinfo
    vulkan-loader
    vulkan-tools
    vulkan-headers
    radeon-profile
    radeontools
    radeontop
  ];

  environment.variables = {
    LIBVA_DRIVER_NAME = "r600"; # Specific driver for HD 7470
    VDPAU_DRIVER = "va_gl"; # Use VA-API backend for VDPAU
  };

  # services.xserver.videoDrivers = [ "modesetting" ]; # fallback driver

  # Optional: Force software acceleration for unsupported codecs
  nixpkgs.config.packageOverrides = pkgs: { ffmpeg = pkgs.ffmpeg-full; };
}
