{ settings, inputs, lib, pkgs, ... }:
let
  inherit (lib) optionals optional;

  # System and hardware configuration
  system = pkgs.stdenv.hostPlatform.system;

  # OpenCL and Mesa configuration
  nixos-opencl = inputs.nixos-opencl;
  mesa-drivers = nixos-opencl.packages.${system}.mesa;
  mesa_icd_dir = "${pkgs.mesa}/share/vulkan/icd.d";

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
    # amf
    # amf-headers
    amdenc
    vpl-gpu-rt
    # Video acceleration
    libva
    # libva1
    libva-utils
    libva-vdpau-driver
    libvdpau
    libvdpau-va-gl # VDPAU backend for video acceleration
    vdpauinfo

    # X11 video drivers
    # xorg.libXv
    # xorg.libXvMC
    # xorg.xf86videoamdgpu

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

    libdrm
    mesa
    llvmPackages.clang
  ];

  # Intel packages
  intelPackages = with pkgs; [
    intel-media-driver
    intel-vaapi-driver
    intel-graphics-compiler
    vaapi-intel-hybrid
  ];

  # Nvidia packages
  nvidiaPackages = with pkgs; [ nvidia-vaapi-driver ];

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
    # opencl-headers
    # clinfo
    clpeak
    (hwloc.override { x11Support = true; })
  ];

  # Graphics tools and utilities
  graphicsTools = with pkgs; [
    # GPU information and monitoring
    gpu-viewer
    vulkan-caps-viewer

    # Intel specific
    # inputs.nixGL.packages.${stdenv.hostPlatform.system}.nixGLIntel
  ];

in {
  config = lib.mkIf (settings.modules.graphics.enable or false) {
    # ========== Graphics Stack Configuration ==========

    # This module configures the graphics stack including:
    # - OpenGL: Cross-platform 2D/3D rendering API
    # - Vulkan: Next-gen low-overhead graphics API
    # - OpenCL: Heterogeneous computing framework
    # - Hardware acceleration (VA-API, VDPAU)

    # Key components configured:
    # - Mesa 3D Graphics Library (OpenGL/Vulkan implementations)
    # - AMD/Intel/NVIDIA driver support
    # - 32-bit compatibility libraries
    # - Development tools and utilities

    environment.variables = {
      # Remove problematic variables that can cause issues with modern Hyprland
      WLR_RENDERER_ALLOW_SOFTWARE = 0;

      # Optimize rendering and disable hardware cursors for Wayland-based compositors.
      WLR_NO_HARDWARE_CURSORS = 1; # Only if cursor issues occur

      # This env var forces wgpu to use OpenGL instead of Vulkan
      WGPU_BACKEND = "vulkan"; # vulkan, metal, dx12, gl

      AMD_DEBUG = "nodcc"; # Fixes rendering bugs on some games

      OCL_ICD_VENDORS = "${pkgs.symlinkJoin {
        name = "opencl-vendors";
        paths = with pkgs; [
          # "${nixos-opencl.packages.${system}.mesa.opencl}/etc/OpenCL/vendors"
          # "${nixos-opencl.packages.${system}.pocl}/etc/OpenCL/vendors"

          "${mesa.opencl}/etc/OpenCL/vendors"
          "${nixos-opencl.packages.${system}.clvk}/etc/OpenCL/vendors"
          "${pocl}/etc/OpenCL/vendors"
          "${intel-ocl}/etc/OpenCL/vendors"
          "${intel-compute-runtime}/etc/OpenCL/vendors"
          "${intel-compute-runtime-legacy1}/etc/OpenCL/vendors"
          # "${pkgs.rocmPackages.clr.icd}/etc/OpenCL/vendors"
        ];
      }}";

      # VK_LOADER_DEBUG = "all";
      # =================================

      # Vulkan ICD files — this should point to the system-wide location from Mesa
      VK_ICD_FILENAMES = builtins.concatStringsSep ":" [
        "/run/opengl-driver-32/share/vulkan/icd.d/radeon_icd.i686.json"
        "/run/opengl-driver/share/vulkan/icd.d/amd_icd64.json"
        "/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json"
        "${pkgs.swiftshader}/share/vulkan/icd.d/vk_swiftshader_icd.json"
      ];

      VK_INSTANCE_LAYERS = "VK_LAYER_KHRONOS_timeline_semaphore";

      # Vulkan ICD (Installable Client Driver) configuration
      # /run/opengl-driver/share/vulkan/icd.d/
      # VK_DRIVER_FILES = "/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json";
      VK_DRIVER_FILES =
        "${mesa_icd_dir}/radeon_icd.x86_64.json:${mesa_icd_dir}/lvp_icd.x86_64.json:${mesa_icd_dir}/gfxstream_vk_icd.x86_64.json";

      # Set Vulkan environment variables
      Vulkan_INCLUDE_DIR = "${pkgs.vulkan-headers}/include";
      Vulkan_LIBRARY = "${pkgs.vulkan-loader}/lib/libvulkan.so.1";
      VK_LAYER_PATH =
        "${pkgs.vulkan-validation-layers}/share/vulkan/explicit_layer.d";
      VULKAN_SDK =
        "${pkgs.vulkan-validation-layers}/share/vulkan/explicit_layer.d";
      # =================================

      # Enable present_wait extension (helps with frame timing on Wayland)
      VK_KHR_PRESENT_WAIT_ENABLED = "1";

      # Presentation mode — "mailbox" is good for low-latency triple buffering
      VK_PRESENT_MODE = "mailbox";

      # Disable problematic/unused Vulkan layers
      VK_LOADER_LAYERS_DISABLE =
        "VK_LAYER_LUNARG_api_dump:VK_LAYER_LUNARG_monitor";

      # Tell Mesa to prefer Wayland
      VK_WSI_MODE = "wayland";

      WLR_RENDERER = "vulkan"; # enable software rendering for wlroots

      # Fixes screen tearing in games & Hyprland.
      # $ vulkaninfo | grep "driverName"
      AMD_VULKAN_ICD = "radv"; # Force RADV instead of AMDVLK

      # Adjust rendering settings for OpenGL and graphics drivers.
      LIBGL_DRI3_ENABLE = "1";

      RADV_PERFTEST = "gpl,sam";
      # ACO_DEBUG = "nowrap,perfwarn";
      # RADV_DEBUG = "nohiz,nodcc,nofmask,noatocdithering";
      # R600_DEBUG = "info,checkir,nowc";
      # R600_DUMP_SHADERS = "vs,ps,cs";

      # RUSTICL_DEBUG = "perf"; # Enable performance warnings

      # Rusticl OpenCL
      # https://docs.mesa3d.org/envvars.html#envvar-RUSTICL_FEATURES
      RUSTICL_ENABLE = "radeonsi";
      # RUSTICL_CL_VERSION = "1.2";
      RUSTICL_DEVICE_TYPE = "gpu";
      RUSTICL_FEATURES = "fp64";
      # RUSTICL_MAX_WORK_GROUPS = "128";

      VAAPI_COMPAT = "1";
      VAAPI_MPEG4_ENABLED = "true";

      # LIBVA_DRIVER_NAME = "radeonsi";
      VDPAU_DRIVER = "radeonsi"; # or "va_gl" for libvdpau-va-gl

      # vblank_mode = "0"; # ? Reduces latency
      __GL_SYNC_TO_VBLANK = "1";
      __GL_THREADED_OPTIMIZATIONS = "1";
      __GL_VRR_ALLOWED = "1";
      __GLX_VENDOR_LIBRARY_NAME = "mesa"; # mesa or nvidia or intel or amd

      GST_VAAPI_ALL_DRIVERS = "1";
      LIBGL_ALWAYS_SOFTWARE = 0; # Disable software rendering fallback
      LIBGL_ALWAYS_INDIRECT = 0;
      LP_NUM_THREADS = settings.common.cpu.cores;
      GALLIUM_DRIVER = "radeonsi";

      HSA_ENABLE_SDMA = "1";
      HSA_OVERRIDE_GFX_VERSION = "7.0.1"; # Older version for Kaveri
      HSA_AMDGPU_GFX = "gfx7"; # Kaveri is GCN 1.1 (gfx7)

      # Disable problematic optimizations
      # HSA_NO_FMA = "1";
      # HSA_NO_SDMA = "1";

      CLVK_SPIRV_ARCH = "spir64";
      CLVK_PHYSICAL_ADDRESSING = 1;

      # Avoid legacy switchable GPU hints (if you only have one GPU)
      DISABLE_LAYER_AMD_SWITCHABLE_GRAPHICS_1 = "1";

      # Some apps dont like integrated + discreet and default to integrated so this should fix that
      __EGL_VENDOR_LIBRARY_FILENAMES =
        "/run/opengl-driver/share/glvnd/egl_vendor.d/50_mesa.json";
      # __EGL_VENDOR_LIBRARY_FILENAMES = "${pkgs.mesa}/share/glvnd/egl_vendor.d/50_mesa.json";

      # LIBGL_DRIVERS_PATH = lib.makeSearchPathOutput "lib" "lib/dri" [ pkgs.mesa ];
      # LIBVA_DRIVERS_PATH = lib.makeSearchPathOutput "out" "lib/dri" [ pkgs.mesa ];
      __EGL_VENDOR_LIBRARY_DIRS = "${pkgs.mesa}/share/glvnd/egl_vendor.d/";

      # Disable Mesa’s experimental device select layer if needed
      # VK_LOADER_DISABLE_LAYER_MESA = "0";

      # Mesa drivers have mesa_glthread flag which enables multi-threading on their OpenGL driver implementation.
      MESA_GLTHREAD = "true";
      mesa_glthread = "true";

      # Mesa OpenGL (somewhat useful)
      MESA_NO_ERROR = "1";
      # MESA_GL_VERSION_OVERRIDE = "4.6";
      # MESA_GLSL_VERSION_OVERRIDE = "460";

      # immediate, mailbox, relaxed, fifo
      MESA_VK_WSI_PRESENT_MODE = "immediate";
      MESA_LOADER_DRIVER_OVERRIDE = "radeonsi";

      MESA_DISK_CACHE_DATABASE = "1";
      MESA_DISK_CACHE_MULTI_FILE = "1";
      MESA_DISK_CACHE_SINGLE_FILE = "0";

      # MESA_GLSL_CACHE_DIR = "~/.cache/mesa_shader_cache";
      MESA_GLSL_CACHE_ENABLE = "true";
      MESA_GLSL_CACHE_MAX_SIZE = "32G";

      # MESA_SHADER_CACHE_DIR = "~/.cache/mesa_shader_cache_db";
      MESA_SHADER_CACHE_DISABLE = "false";
      MESA_SHADER_CACHE_MAX_SIZE = "2G";

      MESA_VK_WSI_DISPLAY = "wayland";
      MESA_VK_WSI_LIST = "wayland";

      GPU_MAX_ALLOC_PERCENT = "100";
      GPU_SINGLE_ALLOC_PERCENT = "100";
      GPU_MAX_HEAP_SIZE = "100";
      GPU_USE_SYNC_OBJECTS = "1";
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
          # OpenCL for AMD GPUs
          # Official Khronos OpenCL ICD Loader
          (lib.hiPrio khronos-ocl-icd-loader)
        ] ++ coreGraphicsPackages ++ vulkanPackages ++ openclPackages;
    };

    # 32-bit graphics packages for compatibility
    hardware.graphics.extraPackages32 = with pkgs.pkgsi686Linux; [
      driversi686Linux.mesa
      mesa_i686
      vulkan-loader
      libva-vdpau-driver
      libvdpau-va-gl
      libva
      vulkan-validation-layers
      vulkan-tools
      vulkan-extension-layer

      intel-media-driver
      intel-vaapi-driver
    ];

    system.activationScripts.vulkan-links = ''
      mkdir -p /usr/lib
      mkdir -p /usr/lib32
      ln -sfn /run/opengl-driver/lib/libvulkan.so.1 /usr/lib/libvulkan.so.1
      ln -sfn /run/opengl-driver/lib/libvulkan.so.1 /usr/lib32/libvulkan.so.1
      ln -sfn ${pkgs.vulkan-loader}/lib/libvulkan.so.1 /usr/lib/libvulkan.so.1
      ln -sfn ${pkgs.pkgsi686Linux.vulkan-loader}/lib/libvulkan.so.1 /usr/lib32/libvulkan.so.1
    '';

    # ========== System Packages ==========
    environment.systemPackages = with pkgs;
      [
        clinfo
        opencl-headers
        vulkan-tools-lunarg

        radeon-profile
        radeontop
        radeontools
      ] ++ coreGraphicsPackages ++ vulkanPackages ++ openclPackages
      ++ graphicsTools ++ lib.flatten _graphics;
  };
}
