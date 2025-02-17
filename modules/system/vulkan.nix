{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.drivers.vulkan) {
  hardware.graphics.extraPackages = [ pkgs.amdvlk ];

  # To enable Vulkan support for 32-bit applications, also add:
  hardware.graphics.extraPackages32 = [ pkgs.driversi686Linux.amdvlk ];

  # Force radv
  environment.variables.AMD_VULKAN_ICD = "RADV";
  # Or
  environment.variables.VK_ICD_FILENAMES =
    "/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json";

  environment.systemPackages = with pkgs; [
    dxvk # A Vulkan-based translation layer for Direct3D
    vkbasalt # Vulkan post processing layer for Linux
    vkquake # Vulkan Quake port based on QuakeSpasm
    vulkan-caps-viewer
    vulkan-cts
    vulkan-extension-layer # Layers providing Vulkan features when native support is unavailable
    vulkan-hdr-layer-kwin6
    vulkan-headers # Vulkan Header files and API registry
    vulkan-helper
    vulkan-loader
    vulkan-memory-allocator
    vulkan-tools # Khronos official Vulkan Tools and Utilities
    vulkan-tools-lunarg
    vulkan-utility-libraries # Set of utility libraries for Vulkan
    vulkan-validation-layers
    vulkan-volk
  ];
}
