{
  settings,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) optionals optional;

  # System and hardware configuration
  system = pkgs.stdenv.hostPlatform.system;

  # User-configurable graphics applications
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

  # ========== Package Collections ==========

  # Tools and applications (Goes to systemPackages)
  graphicsTools = with pkgs; [
    # Graphics APIs and libraries (Headers & Utils)
    libGLU
    glew
    glfw
    vdpauinfo
    libva-utils

    # Image processing
    imagemagick
    jpegoptim
    optipng
    pngquant
    webp-pixbuf-loader
    libwebp
    meshoptimizer

    # OpenAL for audio
    openal
    llvmPackages.clang
    directx-headers

    # Vulkan tools and utilities
    vulkan-tools
    vulkan-tools-lunarg
    vulkan-helper
    vulkan-memory-allocator
    vulkan-volk
    vulkan-cts
    vkbasalt
    vkdt
    dxvk
    vkd3d
    vkd3d-proton
    shaderc
    wgpu-utils

    # OpenCL Tools
    clinfo
    clpeak
    (hwloc.override { x11Support = true; })

    # GPU information and monitoring
    gpu-viewer
    vulkan-caps-viewer
  ];

in
{
  config = lib.mkIf (settings.modules.graphics.enable or false) {

    environment.variables = {
      # Remove problematic variables that can cause issues with modern Hyprland
      WLR_RENDERER_ALLOW_SOFTWARE = "0";
      WLR_NO_HARDWARE_CURSORS = "1";
      WGPU_BACKEND = "vulkan";

      # Cleaned OpenCL Vendors (AMD Only)
      OCL_ICD_VENDORS = "${pkgs.symlinkJoin {
        name = "opencl-vendors";
        paths = with pkgs; [
          "${mesa.opencl}/etc/OpenCL/vendors"
          "${pocl}/etc/OpenCL/vendors"
        ];
      }}";

      VK_KHR_PRESENT_WAIT_ENABLED = "1";
      VK_PRESENT_MODE = "mailbox";
      VK_LOADER_LAYERS_DISABLE = "VK_LAYER_LUNARG_api_dump:VK_LAYER_LUNARG_monitor";

      # Force RADV instead of AMDVLK
      AMD_VULKAN_ICD = "radv";

      # Adjust rendering settings for OpenGL and graphics drivers.
      LIBGL_DRI3_ENABLE = "1";
      RADV_PERFTEST = "gpl,sam,video_encode";

      # Rusticl OpenCL
      RUSTICL_ENABLE = "radeonsi";
      RUSTICL_DEVICE_TYPE = "gpu";
      # RUSTICL_FEATURES = "fp64";

      VAAPI_COMPAT = "1";
      VAAPI_MPEG4_ENABLED = "true";
      LIBVA_DRIVER_NAME = "radeonsi";

      __GL_THREADED_OPTIMIZATIONS = "1";
      __GL_VRR_ALLOWED = "1";
      __GLX_VENDOR_LIBRARY_NAME = "mesa";
      GST_VAAPI_ALL_DRIVERS = "1";
      LIBGL_ALWAYS_SOFTWARE = "0";
      LIBGL_ALWAYS_INDIRECT = "0";
      GALLIUM_DRIVER = "radeonsi";

      # Removed Kaveri GFX overrides completely. Vega 11 will auto-detect correctly.
      HSA_ENABLE_SDMA = "1";

      CLVK_SPIRV_ARCH = "spir64";
      CLVK_PHYSICAL_ADDRESSING = "1";

      DISABLE_LAYER_AMD_SWITCHABLE_GRAPHICS_1 = "1";

      MESA_DISK_CACHE_DATABASE = "1";
      MESA_DISK_CACHE_MULTI_FILE = "1";
      MESA_DISK_CACHE_SINGLE_FILE = "0";
      MESA_GLSL_CACHE_ENABLE = "true";
      MESA_GLSL_CACHE_MAX_SIZE = "2G";
      MESA_SHADER_CACHE_DISABLE = "false";
      MESA_SHADER_CACHE_MAX_SIZE = "2G";
      MESA_VK_WSI_DISPLAY = "wayland";
      MESA_VK_WSI_LIST = "wayland";

      # GPU_MAX_ALLOC_PERCENT = "100";
      # GPU_SINGLE_ALLOC_PERCENT = "100";
      # GPU_MAX_HEAP_SIZE = "100";
      # GPU_USE_SYNC_OBJECTS = "1";
    };

    # ========== Hardware Graphics Configuration ==========
    hardware.graphics = {
      enable = true;
      enable32Bit = true;

      # Drivers and hardware extensions ONLY
      extraPackages = with pkgs; [
        mesa.opencl
        libvdpau-va-gl
      ];

      extraPackages32 = with pkgs.pkgsi686Linux; [
        mesa.opencl
        libvdpau-va-gl
      ];
    };

    # ========== System Packages ==========
    environment.systemPackages = graphicsTools ++ lib.flatten _graphics;
  };
}
