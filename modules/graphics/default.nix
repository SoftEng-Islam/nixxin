{ settings, inputs, lib, pkgs, ... }:
let
  inherit (lib) optionals optional;

  # System and hardware configuration
  system = pkgs.stdenv.hostPlatform.system;

  # OpenCL and Mesa configuration
  nixos-opencl = inputs.nixos-opencl;
  mesa-drivers = [ nixos-opencl.packages.${system}.mesa ];
  mesa_icd_dir = "${mesa-drivers}/share/vulkan/icd.d";

  # Vulkan ICD (Installable Client Driver) configuration
  icds = pkgs.lib.strings.concatStringsSep ":" [
    "${mesa_icd_dir}/radeon_icd.x86_64.json"
    "${mesa_icd_dir}/lvp_icd.x86_64.json"
  ];

  # User-configurable graphics applications
  _graphics_pkgs = settings.modules.graphics;
  _graphics = with pkgs; [
    (optional _graphics_pkgs.blender blender) # 3D modeling and animation
    (optional _graphics_pkgs.darktable darktable) # RAW photo editor
    (optional _graphics_pkgs.drawio drawio) # Diagramming tool
    (optional _graphics_pkgs.figmaLinux figma-linux) # UI/UX design tool
    (optional _graphics_pkgs.gimp gimp) # Image manipulation
    (optional _graphics_pkgs.inkscape inkscape) # Vector graphics editor
    (optional _graphics_pkgs.lunacy lunacy) # Design tool
    (optional _graphics_pkgs.kolourpaint kolourpaint) # Simple paint program
  ];

  # ========== Package Collections ==========

  # Core graphics libraries and drivers
  coreGraphicsPackages = with pkgs; [
    # Graphics APIs and libraries
    libGL
    libGLU
    libGLX
    libglvnd
    libclc
    glew
    glfw

    # Video acceleration
    libva
    libva-utils
    libva-vdpau-driver
    libvdpau
    libvdpau-va-gl # VDPAU backend for video acceleration
    vdpauinfo

    # X11 video drivers
    xorg.libXv
    xorg.libXvMC
    xorg.xf86videoamdgpu

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
  ];

  # Vulkan packages
  vulkanPackages = with pkgs; [
    # Core Vulkan
    vulkan-loader
    vulkan-headers
    vulkan-extension-layer
    vulkan-validation-layers
    vulkan-utility-libraries

    # Vulkan tools and utilities
    vulkan-tools
    vulkan-tools-lunarg
    vulkan-helper
    vulkan-memory-allocator
    vulkan-volk
    vulkan-cts

    # Vulkan applications
    vkbasalt
    vkdt
    vkquake

    # Vulkan-related
    dxvk
    vkd3d
    shaderc
    wgpu-utils
  ];

  # OpenCL and compute
  openclPackages = with pkgs; [
    opencl-headers
    clinfo
    clpeak
    (hwloc.override { x11Support = true; })
  ];

  # Graphics tools and utilities
  graphicsTools = with pkgs; [
    # GPU information and monitoring
    gpu-viewer
    vulkan-caps-viewer

    # Intel specific
    inputs.nixGL.packages.${stdenv.hostPlatform.system}.nixGLIntel
  ];

  # 32-bit packages
  packages32 = with pkgs.pkgsi686Linux; [ mesa_i686 vulkan-loader ];

in {
  config = lib.mkIf (settings.modules.graphics.enable or false) {

    # ========== Graphics Stack Configuration ==========
    #
    # This module configures the graphics stack including:
    # - OpenGL: Cross-platform 2D/3D rendering API
    # - Vulkan: Next-gen low-overhead graphics API
    # - OpenCL: Heterogeneous computing framework
    # - Hardware acceleration (VA-API, VDPAU)
    #
    # Key components configured:
    # - Mesa 3D Graphics Library (OpenGL/Vulkan implementations)
    # - AMD/Intel/NVIDIA driver support
    # - 32-bit compatibility libraries
    # - Development tools and utilities

    environment.variables = {
      # ---- nixos-opencl Start ----
      CLVK_SPIRV_ARCH = "spir64";
      CLVK_PHYSICAL_ADDRESSING = 1;

      # This is the default for Mesa, but we set it explicitly to ensure
      OCL_ICD_VENDORS = "${pkgs.symlinkJoin {
        name = "opencl-vendors";
        paths = [
          "${nixos-opencl.packages.${system}.mesa.opencl}/etc/OpenCL/vendors"
          "${nixos-opencl.packages.${system}.clvk}/etc/OpenCL/vendors"
          "${nixos-opencl.packages.${system}.pocl}/etc/OpenCL/vendors"
          # "${nixos-opencl.packages.${system}.shady}/etc/OpenCL/vendors"
          # "${nixos-opencl.packages.${system}.spirv2clc}/etc/OpenCL/vendors"
        ];
      }}";
      # ---- nixos-opencl End ----

      # WLR_RENDERER = "vulkan"; # enable software rendering for wlroots

      # Avoid legacy switchable GPU hints (if you only have one GPU)
      # DISABLE_LAYER_AMD_SWITCHABLE_GRAPHICS_1 = "1";

      # Vulkan ICD files — this should point to the system-wide location from Mesa
      # VK_ICD_FILENAMES = "${mesa}/share/vulkan/icd.d/radeon_icd.x86_64.json";

      # Enable present_wait extension (helps with frame timing on Wayland)
      # VK_KHR_PRESENT_WAIT_ENABLED = "1";

      # Presentation mode — "mailbox" is good for low-latency triple buffering
      # VK_PRESENT_MODE = "mailbox";

      # Disable problematic/unused Vulkan layers
      # VK_LOADER_LAYERS_DISABLE = "VK_LAYER_LUNARG_api_dump:VK_LAYER_LUNARG_monitor";

      # Tell Mesa to prefer Wayland
      # VK_WSI_MODE = "wayland";

      # Fixes screen tearing in games & Hyprland.
      # vulkaninfo | grep "driverName"
      # AMD_VULKAN_ICD = "radv"; # Force RADV instead of AMDVLK

      # Disable Mesa’s experimental device select layer if needed
      # VK_LOADER_DISABLE_LAYER_MESA = "0";

      # VK_LAYER_PATH = "${vulkan-validation-layers}/share/vulkan/explicit_layer.d";

      # vblank_mode = "0"; # ? Reduces latency

      # Adjust rendering settings for OpenGL and graphics drivers.
      LIBGL_DRI3_ENABLE = "1";

      # LIBGL_ALWAYS_INDIRECT = "1";  # REMOVED: This forced software rendering (llvmpipe)

      VK_DRIVER_FILES = icds;

      # Some apps dont like integrated + discreet and default to integrated so this should fix that
      __EGL_VENDOR_LIBRARY_FILENAMES =
        "/run/opengl-driver/share/glvnd/egl_vendor.d/50_mesa.json";
      # __EGL_VENDOR_LIBRARY_FILENAMES = "${pkgs.mesa}/share/glvnd/egl_vendor.d/50_mesa.json";

      RADV_PERFTEST = "gpl,nogttspill,nircache,sam";

      __GL_SYNC_TO_VBLANK = "1";
      __GL_THREADED_OPTIMIZATIONS = "1";
      __GL_VRR_ALLOWED = "1";
      __GLX_VENDOR_LIBRARY_NAME = "mesa"; # mesa or nvidia or intel or amd

      LIBVA_DRIVER_NAME = "radeonsi";
      VDPAU_DRIVER = "radeonsi"; # or "va_gl" for libvdpau-va-gl

      # Mesa drivers have mesa_glthread flag which enables multi-threading on their OpenGL driver implementation.
      MESA_GLTHREAD = "true";

      # Performance optimization
      MESA_VK_WSI_PRESENT_MODE = "fifo";

      LIBGL_DRIVERS_PATH =
        lib.makeSearchPathOutput "lib" "lib/dri" mesa-drivers;
      # # LIBVA_DRIVERS_PATH = lib.makeSearchPathOutput "out" "lib/dri" intel-driver;
      LIBVA_DRIVERS_PATH =
        lib.makeSearchPathOutput "out" "lib/dri" mesa-drivers;

      # OCL_ICD_VENDORS = "${mesa.opencl}/etc/OpenCL/vendors/";

      # __EGL_VENDOR_LIBRARY_DIRS = "${mesa}/share/glvnd/egl_vendor.d/";

      # Rusticl OpenCL
      # https://docs.mesa3d.org/envvars.html#envvar-RUSTICL_FEATURES
      RUSTICL_ENABLE = "radeonsi";
      RUSTICL_CL_VERSION = "3.0";
      RUSTICL_DEVICE_TYPE = "gpu";

      # Mesa OpenGL (somewhat useful)
      # MESA_GL_VERSION_OVERRIDE = "4.6";
      # MESA_GLSL_VERSION_OVERRIDE = "460";
      # MESA_NO_ERROR = "1";
      # MESA_LOADER_DRIVER_OVERRIDE = "radeonsi,zink";

      # Shader cache
      MESA_SHADER_CACHE_MAX_SIZE = "32G";
      MESA_GLSL_CACHE_ENABLE = "true";

      GST_VAAPI_ALL_DRIVERS = "1";
      LIBGL_ALWAYS_SOFTWARE = "0";
      LP_NUM_THREADS = "8";
      # MESA_DISK_CACHE_DATABASE = "1";
      # MESA_DISK_CACHE_SINGLE_FILE = "0";
      # MESA_GLSL_CACHE_MAX_SIZE = "32G";
      # MESA_DISK_CACHE_MULTI_FILE = "1";
      # MESA_VK_WSI_DISPLAY = "wayland";
      # MESA_VK_WSI_LIST = "wayland";

      # VAAPI_COMPAT = "1";
      # VAAPI_MPEG4_ENABLED = "1";
    };

    # ========== Hardware Graphics Configuration ==========
    hardware.graphics = {
      enable = true;
      enable32Bit = true;

      # Use unstable Mesa for better performance with latest Hyprland
      package = pkgs.mesa;
      package32 = pkgs.pkgsi686Linux.mesa;

      # Note: amdvlk has been deprecated, RADV is now the default driver
      extraPackages = with pkgs;
        [

          # Official Khronos OpenCL ICD Loader
          (lib.hiPrio khronos-ocl-icd-loader)
        ] ++ coreGraphicsPackages ++ vulkanPackages ++ openclPackages;
    };

    # 32-bit graphics packages for compatibility
    hardware.graphics.extraPackages32 = packages32;

    # ========== System Packages ==========
    environment.systemPackages = with pkgs;
      [ clinfo opencl-headers ] ++ coreGraphicsPackages ++ vulkanPackages
      ++ openclPackages ++ graphicsTools ++ lib.flatten _graphics;
  };
}
