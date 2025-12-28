{ settings, lib, pkgs, ... }: {
  environment.variables = {
    # Avoid legacy switchable GPU hints (if you only have one GPU)
    DISABLE_LAYER_AMD_SWITCHABLE_GRAPHICS_1 = "1";

    # Vulkan ICD files — this should point to the system-wide location from Mesa
    VK_ICD_FILENAMES = "${pkgs.mesa}/share/vulkan/icd.d/radeon_icd.x86_64.json";

    # Enable present_wait extension (helps with frame timing on Wayland)
    VK_KHR_PRESENT_WAIT_ENABLED = "1";

    # Presentation mode — "mailbox" is good for low-latency triple buffering
    VK_PRESENT_MODE = "mailbox";

    # Disable problematic/unused Vulkan layers
    VK_LOADER_LAYERS_DISABLE =
      "VK_LAYER_LUNARG_api_dump:VK_LAYER_LUNARG_monitor";

    # Disable Mesa’s experimental device select layer if needed
    VK_LOADER_DISABLE_LAYER_MESA = "1";

    # Tell Mesa to prefer Wayland
    VK_WSI_MODE = "wayland";

    # Fixes screen tearing in games & Hyprland.
    # vulkaninfo | grep "driverName"
    AMD_VULKAN_ICD = "radv"; # Force RADV instead of AMDVLK
  };
  environment.systemPackages = with pkgs; [
    dxvk # A Vulkan-based translation layer for Direct3D
    gpu-viewer # A front-end to glxinfo, vulkaninfo, clinfo and es2_info
    vkbasalt # Vulkan post processing layer for Linux

    shaderc
    vulkan-extension-layer # Layers providing Vulkan features when native support is unavailable
    vulkan-headers # Vulkan Header files and API registry
    vulkan-loader
    vulkan-tools # Khronos official Vulkan Tools and Utilities
    vulkan-utility-libraries # Set of utility libraries for Vulkan
    vulkan-caps-viewer
    vulkan-cts
    vulkan-hdr-layer-kwin6
    vulkan-helper
    vulkan-memory-allocator
    vulkan-tools-lunarg
    vulkan-validation-layers
    vulkan-volk
    wgpu-utils
  ];
}
