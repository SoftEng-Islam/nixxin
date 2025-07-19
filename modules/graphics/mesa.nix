{ settings, lib, pkgs, ... }:
lib.mkIf (settings.modules.system.mesa) {
  environment.systemPackages = with pkgs; [
    mesa
    mesa-demos
    mesa-gl-headers
    mesa_glu
    mesa_i686
  ];
  environment.variables = {
    GST_VAAPI_ALL_DRIVERS = "1";
    LIBGL_ALWAYS_SOFTWARE = "0";
    LIBVA_DRIVERS_PATH = "/usr/lib/dri";
    LP_NUM_THREADS = "8";
    MESA_DISK_CACHE_DATABASE = "1";
    MESA_DISK_CACHE_SINGLE_FILE = "0";
    MESA_GLSL_CACHE_ENABLE = "true";
    MESA_GLSL_CACHE_DIR =
      "/home/${settings.user.username}/.cache/mesa_shader_cache";
    MESA_GLSL_CACHE_MAX_SIZE = "32G";
    MESA_SHADER_CACHE_MAX_SIZE = "32G";
    MESA_LOADER_DRIVER_OVERRIDE = "radeonsi";
    MESA_DISK_CACHE_MULTI_FILE = "1";
    MESA_NO_ERRORS = "1";
    MESA_SHADER_CACHE_DIR =
      "/home/${settings.user.username}/.cache/mesa_shader_cache_db";
    MESA_VK_WSI_DISPLAY = "wayland";
    MESA_VK_WSI_LIST = "wayland";
    OCL_ICD_VENDORS =
      "/home/${settings.user.username}/.local/etc/OpenCL/vendors";
    # ONEAPI_DEVICE_SELECTOR = "opencl:cpu";
    # OPENCV_OPENCL_DEVICE = "NVIDIA CUDA:GPU:0,Intel:GPU:0";
    RUSTICL_DEVICE_TYPE = "gpu";
    RUSTICL_ENABLE = "radeonsi,iris,llvmpipe";
    RUSTICL_FEATURES = "fp64,intel";
    RUSTICL_MAX_WORK_GROUPS = "128";
    VAAPI_COMPAT = "1";
    VAAPI_MPEG4_ENABLED = "1";
    VDPAU_DRIVER = "va_gl";
    VK_WSI_MODE = "wayland";
    ZINK_BATCH_COUNT = "8";
    ZINK_SHADER_CACHE_DIR =
      "/home/${settings.user.username}/.cache/zink_shader_cache_db";
  };
}
