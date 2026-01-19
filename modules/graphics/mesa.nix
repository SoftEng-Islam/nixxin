# Propagates environment variables to make apps that use direct rendering work
# on non-NixOS systems. This is needed by kitty and Neovide
{ settings, lib, pkgs, ... }:
with pkgs;
(let mesa-drivers = [ mesa ];
in lib.mkIf (settings.modules.graphics.mesa) {

  hardware.graphics.extraPackages = with pkgs; [ mesa ];
  environment.variables = with pkgs; {
    # some apps dont like integrated + discreet and default to integrated
    # this should fix that
    # __EGL_VENDOR_LIBRARY_FILENAMES = "/run/opengl-driver/share/glvnd/egl_vendor.d/50_mesa.json";
    __EGL_VENDOR_LIBRARY_FILENAMES =
      "${pkgs.mesa}/share/glvnd/egl_vendor.d/50_mesa.json";
    RADV_PERFTEST =
      "gpl,nogttspill,nircache,localbos,video_decode,video_encode,sam";
    # Mesa drivers have mesa_glthread flag which enables multi-threading on their OpenGL driver implementation.
    MESA_GLTHREAD = "true";
    __GL_SYNC_TO_VBLANK = "1";
    __GL_THREADED_OPTIMIZATIONS = "1";
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "mesa"; # mesa or nvidia or intel or amd
    NVD_BACKEND = "direct";
    __GL_VRR_ALLOWED = "1";
    VK_DRIVER_FILES = "${lib.concatStringsSep ":" [
      "${pkgs.mesa}/share/vulkan/icd.d/radeon_icd.x86_64.json"
      "${pkgs.mesa_i686}/share/vulkan/icd.d/radeon_icd.i686.json"
    ]}";

    # Performance optimization
    MESA_VK_WSI_PRESENT_MODE = "fifo";

    # Optional: For Polaris cards (Radeon 500 series) OpenCL support
    ROC_ENABLE_PRE_VEGA = "1";

    LIBGL_DRIVERS_PATH = lib.makeSearchPathOutput "lib" "lib/dri" mesa-drivers;
    # # LIBVA_DRIVERS_PATH = lib.makeSearchPathOutput "out" "lib/dri" intel-driver;
    LIBVA_DRIVERS_PATH = lib.makeSearchPathOutput "out" "lib/dri" mesa-drivers;

    OCL_ICD_VENDORS = "${mesa.opencl}/etc/OpenCL/vendors/";
    __EGL_VENDOR_LIBRARY_DIRS = "${mesa}/share/glvnd/egl_vendor.d/";

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
    # VDPAU_DRIVER = "va_gl";
  };

  environment.systemPackages = with pkgs; [
    mesa # An open source 3D graphics library
    mesa-gl-headers
    mesa_glu # OpenGL utility library
    mesa_i686 # Open source 3D graphics library
    mesa-demos # Collection of demos and test programs for OpenGL and Mesa
    driversi686Linux.mesa # An open source 3D graphics library

    openal # OpenAL alternative
    opencl-headers # Khronos OpenCL headers version 2023.12.14
    clinfo # Print all known information about all available OpenCL platforms and devices in the system
    clpeak # Tool which profiles OpenCL devices to find their peak capacities

    # Portable abstraction of hierarchical architectures for high-performance computing
    (hwloc.override { x11Support = true; })
  ];
})
