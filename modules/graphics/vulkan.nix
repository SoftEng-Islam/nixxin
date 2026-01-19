{ settings, lib, pkgs, ... }: {
  environment.variables = with pkgs; {
    WLR_RENDERER = "vulkan"; # enable software rendering for wlroots

    # Avoid legacy switchable GPU hints (if you only have one GPU)
    DISABLE_LAYER_AMD_SWITCHABLE_GRAPHICS_1 = "1";

    # Vulkan ICD files — this should point to the system-wide location from Mesa
    VK_ICD_FILENAMES = "${mesa}/share/vulkan/icd.d/radeon_icd.x86_64.json";

    VK_DRIVER_FILES = "${lib.concatStringsSep ":" [
      "${pkgs.mesa}/share/vulkan/icd.d/radeon_icd.x86_64.json"
      "${pkgs.mesa_i686}/share/vulkan/icd.d/radeon_icd.i686.json"
    ]}";

    # Enable present_wait extension (helps with frame timing on Wayland)
    VK_KHR_PRESENT_WAIT_ENABLED = "1";

    # Presentation mode — "mailbox" is good for low-latency triple buffering
    VK_PRESENT_MODE = "mailbox";

    # Disable problematic/unused Vulkan layers
    # VK_LOADER_LAYERS_DISABLE = "VK_LAYER_LUNARG_api_dump:VK_LAYER_LUNARG_monitor";

    # Tell Mesa to prefer Wayland
    # VK_WSI_MODE = "wayland";

    # Fixes screen tearing in games & Hyprland.
    # vulkaninfo | grep "driverName"
    AMD_VULKAN_ICD = "radv"; # Force RADV instead of AMDVLK

    # Disable Mesa’s experimental device select layer if needed
    # VK_LOADER_DISABLE_LAYER_MESA = "0";

    # VK_LAYER_PATH = "${vulkan-validation-layers}/share/vulkan/explicit_layer.d";
  };
  environment.systemPackages = with pkgs; [
    dxvk # A Vulkan-based translation layer for Direct3D
    shaderc # Collection of tools, libraries and tests for shader compilation
    vkbasalt # Vulkan post processing layer for Linux
    vulkan-cts # Khronos Vulkan Conformance Tests
    vulkan-extension-layer # Layers providing Vulkan features when native support is unavailable
    vulkan-headers # Vulkan Header files and API registry
    vulkan-helper # Simple CLI app used to interface with basic Vulkan APIs
    vulkan-loader # LunarG Vulkan loader
    vulkan-memory-allocator # Easy to integrate Vulkan memory allocation library
    vulkan-tools # Khronos official Vulkan Tools and Utilities
    vulkan-tools-lunarg # LunarG Vulkan Tools and Utilities
    vulkan-utility-libraries # Set of utility libraries for Vulkan
    vulkan-volk # Meta loader for Vulkan API
    wgpu-utils # Safe and portable GPU abstraction in Rust, implementing WebGPU API

    # Apps
    gpu-viewer # A front-end to glxinfo, vulkaninfo, clinfo and es2_info
    vulkan-caps-viewer # Vulkan hardware capability viewer
  ];
}
