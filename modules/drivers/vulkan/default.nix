{ settings, lib, pkgs, ... }: {
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
