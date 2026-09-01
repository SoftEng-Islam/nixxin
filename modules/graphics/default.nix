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

    # Vulkan runtime tools (small, useful for debugging)
    vulkan-tools
    vulkan-tools-lunarg
    vulkan-helper
    vkbasalt
    shaderc
    wgpu-utils

    # OpenCL Tools
    clinfo
    # clpeak      # benchmark, not needed at runtime
    # (hwloc.override { x11Support = true; }) # optional

    # GPU information and monitoring
    gpu-viewer
    vulkan-caps-viewer

    # Removed (too large / dev-only — add to a devShell if needed):
    # llvmPackages.clang   (~1 GB)
    # vulkan-cts           (conformance test suite, huge)
    # dxvk / vkd3d / vkd3d-proton  (Wine-specific, belongs in windows module)
    # vkdt                 (darktable fork, use darktable instead)
    # directx-headers      (dev-only)
    # openal               (audio, not graphics)
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
          # Pulled from unstable: nixos-26.05's mesa.opencl still lacks the
          # patched mesa-libclc fork (karolherbst/mesa-libclc), which only
          # landed on nixos-unstable. Stable Vulkan/GL drivers stay on 26.05.
          "${pkgs.unstable.mesa.opencl}/etc/OpenCL/vendors"
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
      enable32Bit = false;

      # Drivers and hardware extensions ONLY
      extraPackages = with pkgs; [
        unstable.mesa.opencl
        # Mesa includes RADV Vulkan driver for AMD (enabled by default)
        mesa
        # Video acceleration
        libvdpau-va-gl
        libva-vdpau-driver
      ];

      extraPackages32 = with pkgs.pkgsi686Linux; [
        mesa.opencl
        mesa
        libvdpau-va-gl
        libva-vdpau-driver
      ];
    };

    # ========== System Packages ==========
    environment.systemPackages = graphicsTools ++ lib.flatten _graphics;
  };
}
