{ config, inputs, lib, settings, pkgs, ... }:
let
  # System and hardware configuration
  system = pkgs.stdenv.hostPlatform.system;
  nixos-opencl = inputs.nixos-opencl;
  mesa-drivers = nixos-opencl.packages.${system}.mesa;
  # Libraries we want available from nixpkgs
  libPath = with pkgs;
    pkgs.lib.makeLibraryPath [
      vulkan-loader # libvulkan.so
      vulkan-validation-layers # validation layer runtime
      pipewire
      sqlite
      mesa
      mesa_i686
      ocl-icd
      opencl-headers
      llvmPackages.openmp
    ];
in lib.mkIf (settings.modules.env.enable or false) {
  # Environment Variables
  # find /nix/store -name "something"
  environment = {
    # localBinInPath = false;
    variables = {
      # ---- nixos-opencl Start ----
      LD_LIBRARY_PATH =
        lib.mkForce "$LD_LIBRARY_PATH:${libPath}:/run/opengl-driver/lib";

      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";

      # Disable window decoration for Wayland Qt apps
      QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;

      # Set the backend for GDK (GIMP Drawing Kit) to support Wayland and X11
      GDK_BACKEND = "wayland,x11";

      # ---- QT ---- #
      DISABLE_QT5_COMPAT = 0;
      QT_AUTO_SCREEN_SCALE_FACTOR = 1;
      QT_QPA_PLATFORM = "wayland;xcb";

      # "WLR_DRM_NO_ATOMIC,1"
      # WLR_BACKEND = "vulkan";
      # WLR_RENDERER = "vulkan";

      AQ_DRM_DEVICES = "/dev/dri/card1"; # CHANGEME: Related to the GPU

      __GL_ALLOW_SOFTWARE = 1;
      MOZ_DISABLE_RDD_SANDBOX = 1;

      DEVENVD_DISABLE_VERSION_CHECK = "1";
      DEVENVD_NO_ANALYTICS = "1";

      EDITOR = settings.common.EDITOR;
      VISUAL = settings.common.VISUAL;

      TERM = settings.common.TERM;
      BROWSER = settings.common.webBrowser;

      # Fixes `bad interpreter: Text file busy`
      # https://github.com/NixOS/nixpkgs/issues/314713
      UV_USE_IO_URING = "0";

      SDL_VIDEODRIVER = "wayland";
      BEMENU_BACKEND = "wayland";
      CLUTTER_BACKEND = "wayland";
      ELM_ENGINE = "wayland_egl";
      ECORE_EVAS_ENGINE = "wayland_egl";

      # ---- Electron ---- #
      # Enable Wayland support for Electron apps
      # ELECTRON_OZONE_PLATFORM_HINT = "auto";
      ELECTRON_ENABLE_WAYLAND = "1";
      NIXOS_OZONE_WL = "1"; # Optional, hint electron apps to use wayland

      # Configure the cursor theme and size for graphical sessions.
      XCURSOR_PATH =
        lib.mkForce "${settings.common.cursor.package}/share/icons";
      XCURSOR_THEME = settings.common.cursor.name;
      XCURSOR_SIZE = toString settings.common.cursor.size;

      # Java-specific setting for better compatibility with Wayland.
      _JAVA_AWT_WM_NONREPARENTING = "1";

      MOZ_DBUS_REMOTE = "1";

      # Enables Wayland for Mozilla apps and EGL.
      MOZ_ENABLE_WAYLAND = 1;
      EGL_PLATFORM = "wayland";
    };
  };
}
