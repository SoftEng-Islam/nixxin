{ settings, lib, pkgs, ... }: {
  environment.variables = {
    # Avoid legacy switchable GPU hints (if you only have one GPU)
    DISABLE_LAYER_AMD_SWITCHABLE_GRAPHICS_1 = "1";

    # Vulkan ICD files — this should point to the system-wide location from Mesa
    VK_ICD_FILENAMES = "${pkgs.mesa}/share/vulkan/icd.d/radeon_icd.x86_64.json";

    # Vulkan Layer path — system-wide layer files
    # VK_LAYER_PATH =
    #   "${pkgs.vulkan-validation-layers}/share/vulkan/explicit_layer.d";

    # Enable present_wait extension (helps with frame timing on Wayland)
    VK_KHR_PRESENT_WAIT_ENABLED = "1";

    # You are not using Optimus or NVIDIA, so these are not needed:
    # __VK_LAYER_NV_optimus = "NVIDIA_only";   ← REMOVE
    # VK_DEVICE_FILTER = "intel";             ← REMOVE

    # Presentation mode — "mailbox" is good for low-latency triple buffering
    VK_PRESENT_MODE = "mailbox";

    # Disable problematic/unused Vulkan layers
    VK_LOADER_LAYERS_DISABLE =
      "VK_LAYER_LUNARG_api_dump:VK_LAYER_LUNARG_monitor";

    # Disable Mesa’s experimental device select layer if needed
    VK_LOADER_DISABLE_LAYER_MESA = "1";

    # Tell Mesa to prefer Wayland
    MESA_VK_WSI_LIST = "wayland";
    VK_WSI_MODE = "wayland";

    # Fixes screen tearing in games & Hyprland.
    # vulkaninfo | grep "driverName"
    AMD_VULKAN_ICD = "radv"; # Force RADV instead of AMDVLK

    #? What the Differante?
    # VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json";
    # VK_ICD_FILENAMES = "${pkgs.amdvlk}/share/vulkan/icd.d/amd_icd64.json";

    # VK_LAYER_PATH = "/etc/vulkan/layer.d";
    # VK_LAYER_PATH = "/run/opengl-driver/share/vulkan/explicit_layer.d";

    # AMD_VULKAN_DRIVER = "RADV";
  };
  environment.systemPackages = with pkgs; [
    dxvk # A Vulkan-based translation layer for Direct3D
    gpu-viewer # A front-end to glxinfo, vulkaninfo, clinfo and es2_info
    vkbasalt # Vulkan post processing layer for Linux
    # vkquake # Vulkan Quake port based on QuakeSpasm
    shaderc
    vulkan-extension-layer # Layers providing Vulkan features when native support is unavailable
    vulkan-headers # Vulkan Header files and API registry
    vulkan-tools # Khronos official Vulkan Tools and Utilities
    vulkan-utility-libraries # Set of utility libraries for Vulkan
    vulkan-caps-viewer
    vulkan-cts
    vulkan-hdr-layer-kwin6
    vulkan-helper
    vulkan-loader
    vulkan-memory-allocator
    vulkan-tools-lunarg
    vulkan-validation-layers
    vulkan-volk
    wgpu-utils
  ];
}
