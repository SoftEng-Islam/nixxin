{ settings, inputs, lib, pkgs, ... }:
let
  inherit (lib) optionals optional;
  system = pkgs.stdenv.hostPlatform.system;
  nixos-opencl = inputs.nixos-opencl;
  mesa-drivers = [ nixos-opencl.packages.${system}.mesa ];
  mesa_icd_dir = "${mesa-drivers}/share/vulkan/icd.d";
  icds = pkgs.lib.strings.concatStringsSep ":" [
    "${mesa_icd_dir}/radeon_icd.x86_64.json"
    "${mesa_icd_dir}/lvp_icd.x86_64.json"
  ];

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
in {
  imports = optionals (settings.modules.graphics.enable or false)
    [ ./nixos-opencl.nix ];
  config = lib.mkIf (settings.modules.graphics.enable or false) {

    #* OpenGL (Open Graphics Library) is a cross-platform,
    #* open standard API for rendering 2D and 3D vector graphics.
    #* It allows developers to communicate with the GPU to create visually rich applications such as:
    # => Games
    # => CAD software
    # => Desktop environments and compositors (like Hyprland or GNOME)

    #* Key Points:
    # => Written in C; has bindings in many languages (C++, Python, Rust, etc.)
    # => Managed by the Khronos Group
    # => Often used with GLSL (OpenGL Shading Language) for writing shaders
    # => Alternative APIs: Vulkan, DirectX, Metal

    environment.variables = {
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

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      # Use unstable Mesa for better performance with latest Hyprland
      package = pkgs.mesa;
      package32 = pkgs.pkgsi686Linux.mesa;
      # Note: amdvlk has been deprecated, RADV is now the default driver
      extraPackages = with pkgs; [
        # amdvlk removed - RADV is now the default AMD Vulkan driver
        libva # Video acceleration API
        libvdpau-va-gl # VDPAU backend for video acceleration

        vulkan-memory-allocator
        vulkan-extension-layer
        vulkan-loader
        vulkan-tools
        vulkan-utility-libraries
        vulkan-headers
        vulkan-helper
        vulkan-tools-lunarg
        vulkan-volk

        glew
        glfw
        libclc
        libGL
        libGLU
        libglvnd
        libGLX
        libva-utils
        libva-vdpau-driver
        libvdpau
        vdpauinfo
        xorg.libXv
        xorg.libXvMC
        dxvk
        vkdt
        vkquake
        vkd3d
        libva
        libva-utils
        libdrm
        vulkan-loader
        vulkan-validation-layers
        vulkan-extension-layer
        libglvnd
        mesa-drivers
      ];
    };
    hardware.graphics.extraPackages32 = with pkgs.pkgsi686Linux; [
      mesa_i686
      vulkan-loader
    ];

    environment.systemPackages = with pkgs;
      [
        imagemagick
        jpegoptim
        optipng
        pngquant
        webp-pixbuf-loader
        libwebp
        libdrm # Direct Rendering Manager library and headers
        xorg.xf86videoamdgpu
        meshoptimizer

        # mesa # An open source 3D graphics library
        # mesa-gl-headers
        # mesa_glu # OpenGL utility library
        # mesa_i686 # Open source 3D graphics library
        # mesa-demos # Collection of demos and test programs for OpenGL and Mesa
        # driversi686Linux.mesa # An open source 3D graphics library

        openal # OpenAL alternative
        opencl-headers # Khronos OpenCL headers version 2023.12.14
        clinfo # Print all known information about all available OpenCL platforms and devices in the system
        clpeak # Tool which profiles OpenCL devices to find their peak capacities

        # Portable abstraction of hierarchical architectures for high-performance computing
        (hwloc.override { x11Support = true; })

        inputs.nixGL.packages.${stdenv.hostPlatform.system}.nixGLIntel
        # mesa
        # mesa_glu
        # mesa_i686
        # mesa-gl-headers
        # glew
        # glfw
        # libGL
        # libGLU
        # freeglut

        # glmark2 # OpenGL (ES) 2.0 benchmark

        shaderc # Collection of tools, libraries and tests for shader compilation
        vkbasalt # Vulkan post processing layer for Linux
        vulkan-cts # Khronos Vulkan Conformance Tests
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

      ] ++ lib.flatten _graphics;
  };
}
