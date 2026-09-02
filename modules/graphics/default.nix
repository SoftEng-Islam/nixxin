{
  settings,
  lib,
  pkgs,
  pkgs-older,
  ...
}:
let
  inherit (lib) optional;

  rocmMode = settings.modules.system.rocm;
  rocmEnabled = rocmMode != "none";
  useOldRocm = rocmMode == "old";
  rocm = if useOldRocm then pkgs-older.rocmPackages else pkgs.rocmPackages;

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

  graphicsTools = with pkgs; [
    libGLU
    glew
    glfw
    vdpauinfo
    libva-utils
    imagemagick
    jpegoptim
    optipng
    pngquant
    webp-pixbuf-loader
    libwebp
    meshoptimizer
    vulkan-tools
    vulkan-tools-lunarg
    vulkan-helper
    vkbasalt
    shaderc
    wgpu-utils
    clinfo
    gpu-viewer
    vulkan-caps-viewer
  ];

in
{
  config = lib.mkIf (settings.modules.graphics.enable or false) {

    environment.variables = {
      WLR_RENDERER_ALLOW_SOFTWARE = "0";
      WLR_NO_HARDWARE_CURSORS = "1";
      WGPU_BACKEND = "vulkan";

      # Cleaned OpenCL Vendors (AMD Only)
      OCL_ICD_VENDORS =
        "${pkgs.symlinkJoin {
          name = "opencl-vendors";
          paths = with pkgs; [
            "${mesa.opencl}/etc/OpenCL/vendors"
            "${pocl}/etc/OpenCL/vendors"
          ];
        }}"
        + lib.optionalString rocmEnabled ":/etc/OpenCL/vendors";

      VK_KHR_PRESENT_WAIT_ENABLED = "1";
      VK_PRESENT_MODE = "mailbox";
      VK_LOADER_LAYERS_DISABLE = "VK_LAYER_LUNARG_api_dump:VK_LAYER_LUNARG_monitor";
      AMD_VULKAN_ICD = "radv";
      LIBGL_DRI3_ENABLE = "1";
      RADV_PERFTEST = "gpl,sam,video_encode";
      RUSTICL_ENABLE = "radeonsi";
      RUSTICL_DEVICE_TYPE = "gpu";
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
      GPU_MAX_ALLOC_PERCENT = "100";
      GPU_SINGLE_ALLOC_PERCENT = "100";
      GPU_MAX_HEAP_SIZE = "100";
    }
    // lib.optionalAttrs useOldRocm {
      HSA_OVERRIDE_GFX_VERSION = "9.0.6";
    };

    hardware.graphics = {
      enable = true;
      enable32Bit = true;

      extraPackages = with pkgs; [
        unstable.mesa.opencl
        mesa
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

    environment.systemPackages = graphicsTools ++ lib.flatten _graphics;
  };
}
