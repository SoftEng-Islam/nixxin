{ settings, lib, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    dxvk # A Vulkan-based translation layer for Direct3D
    vkbasalt # Vulkan post processing layer for Linux
    vkquake # Vulkan Quake port based on QuakeSpasm
    vulkan-extension-layer # Layers providing Vulkan features when native support is unavailable
    vulkan-headers # Vulkan Header files and API registry
    vulkan-tools # Khronos official Vulkan Tools and Utilities
    vulkan-utility-libraries # Set of utility libraries for Vulkan
  ];
}
