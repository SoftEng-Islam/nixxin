# Propagates environment variables to make apps that use direct rendering work
# on non-NixOS systems. This is needed by kitty and Neovide
{ settings, lib, pkgs, ... }:
with pkgs;
(let
  enable32bits = true;
  mesa-drivers = [ mesa ];
  # ++ lib.optional enable32bits pkgsi686Linux.mesa.drivers;
  intel-driver = [ intel-media-driver vaapiIntel ];
  # Note: intel-media-driver is disabled for i686 until https://github.com/NixOS/nixpkgs/issues/140471 is fixed
  # ++ lib.optionals enable32bits [ /* pkgsi686Linux.intel-media-driver */ driversi686Linux.vaapiIntel ];
  libvdpau = [ libvdpau-va-gl ];
  # ++ lib.optional enable32bits pkgsi686Linux.libvdpau-va-gl;
  glxindirect = runCommand "mesa_glxindirect" { } ''
    mkdir -p $out/lib
    ln -s ${mesa.drivers}/lib/libGLX_mesa.so.0 $out/lib/libGLX_indirect.so.0
  '';
  # generate a file with the listing of all the icd files
  icd = runCommand "mesa_icd" { } (
    # 64 bits icd
    ''
      ls ${mesa.drivers}/share/vulkan/icd.d/*.json > f
    ''
    #  32 bits ones
    # + lib.optionalString enable32bits ''
    #   ls ${pkgsi686Linux.mesa.drivers}/share/vulkan/icd.d/*.json >> f
    # ''
    # concat everything as a one line string with ":" as seperator
    + ''cat f | xargs | sed "s/ /:/g" > $out'');
in lib.mkIf (settings.modules.graphics.mesa) {
  environment.variables = with pkgs; {

    LIBGL_DRIVERS_PATH = lib.makeSearchPathOutput "lib" "lib/dri" mesa-drivers;
    # # LIBVA_DRIVERS_PATH = lib.makeSearchPathOutput "out" "lib/dri" intel-driver;
    LIBVA_DRIVERS_PATH = lib.makeSearchPathOutput "out" "lib/dri" mesa-drivers;

    # ? What this?
    # LD_LIBRARY_PATH = "${lib.makeLibraryPath mesa-drivers}:${
    #     lib.makeSearchPathOutput "lib" "lib/vdpau" libvdpau
    #   }:${
    #     lib.makeLibraryPath [ glxindirect libglvnd vulkan-loader xorg.libICE ]
    #   }";

    VK_LAYER_PATH = "${vulkan-validation-layers}/share/vulkan/explicit_layer.d";

    # VK_ICD_FILENAMES = "$(cat ${icd})";

    OCL_ICD_VENDORS = "${mesa.opencl}/etc/OpenCL/vendors/";
    __EGL_VENDOR_LIBRARY_DIRS = "${mesa.drivers}/share/glvnd/egl_vendor.d/";

    # Rusticl OpenCL
    RUSTICL_CL_VERSION = "3.0";
    RUSTICL_DEVICE_TYPE = "gpu";
    RUSTICL_ENABLE = "radeonsi";
    
    # https://docs.mesa3d.org/envvars.html#envvar-RUSTICL_FEATURES
    # RUSTICL_FEATURES = "fp64";
    
    RUSTICL_MAX_WORK_GROUPS = "128";

    # Mesa OpenGL (somewhat useful)
    MESA_GL_VERSION_OVERRIDE = "4.6";
    MESA_GLSL_VERSION_OVERRIDE = "460";
    MESA_NO_ERROR = "1";
    # MESA_LOADER_DRIVER_OVERRIDE = "radeonsi,zink";

    # Shader cache
    MESA_SHADER_CACHE_MAX_SIZE = "32G";
    # MESA_SHADER_CACHE_DIR = "/home/${settings.user.username}/.cache/mesa_shader_cache_db";
    MESA_GLSL_CACHE_ENABLE = "true";
    # MESA_GLSL_CACHE_DIR = "/home/${settings.user.username}/.cache/mesa_shader_cache";

    GST_VAAPI_ALL_DRIVERS = "1";
    LIBGL_ALWAYS_SOFTWARE = "0";
    # LIBVA_DRIVERS_PATH = "/usr/lib/dri";
    LP_NUM_THREADS = "8";
    MESA_DISK_CACHE_DATABASE = "1";
    MESA_DISK_CACHE_SINGLE_FILE = "0";
    MESA_GLSL_CACHE_MAX_SIZE = "32G";
    MESA_DISK_CACHE_MULTI_FILE = "1";
    MESA_VK_WSI_DISPLAY = "wayland";
    MESA_VK_WSI_LIST = "wayland";

    # OCL driver location
    # nix build nixpkgs#mesa.opencl --print-out-paths --no-link
    # OCL_ICD_VENDORS = "/home/${settings.user.username}/.local/etc/OpenCL/vendors";
    # OCL_ICD_VENDORS = "/run/opengl-driver/etc/OpenCL/vendors";
    # OCL_ICD_VENDORS = "${mesa.opencl}/etc/OpenCL/vendors/";

    # ONEAPI_DEVICE_SELECTOR = "opencl:cpu";
    # OPENCV_OPENCL_DEVICE = "NVIDIA CUDA:GPU:0,Intel:GPU:0";
    VAAPI_COMPAT = "1";
    VAAPI_MPEG4_ENABLED = "1";
    VDPAU_DRIVER = "va_gl";
    VK_WSI_MODE = "wayland";
    ZINK_BATCH_COUNT = "8";
    # ZINK_SHADER_CACHE_DIR = "/home/${settings.user.username}/.cache/zink_shader_cache_db";
  };

  environment.systemPackages = with pkgs;
  [
    mesa # An open source 3D graphics library
    mesa-gl-headers
    mesa_glu # OpenGL utility library
    mesa_i686 # Open source 3D graphics library
    mesa-demos # Collection of demos and test programs for OpenGL and Mesa
    driversi686Linux.mesa # An open source 3D graphics library
  ];
})
