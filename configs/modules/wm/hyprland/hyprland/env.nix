{ settings, ... }: {
  wayland.windowManager.hyprland.settings = {
    env = [
      # Environment Variables Configuration
      # Environment variables. See https://wiki.hyprland.org/Configuring/Environment-variables/

      "XDG_CURRENT_DESKTOP,Hyprland"
      "XDG_SESSION_DEKSTOP,Hyprland"

      # Disable window decoration for Wayland Qt applications
      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      # Enable automatic screen scaling for Qt applications
      "QT_AUTO_SCREEN_SCALE_FACTOR,1"
      # Set the scale factor for Qt applications
      "QT_SCALE_FACTOR,1"

      # env = EDITOR,vim # Set the default editor (uncomment to use vim)

      # --------- Input method --------- #
      # See https://fcitx-im.org/wiki/Using_Fcitx_5_on_Wayland
      "QT_IM_MODULE, fcitx"
      "XMODIFIERS, @im=fcitx"
      # env = GTK_IM_MODULE, wayland   # Crashes electron apps in xwayland
      # env = GTK_IM_MODULE, fcitx     # My Gtk apps no longer require this to work with fcitx5 hmm

      "SDL_IM_MODULE, fcitx"
      "GLFW_IM_MODULE, ibus"
      "INPUT_METHOD, fcitx"

      # --------- Themes --------- #
      # Set the platform theme for Qt5 and Qt6 applications
      # env = QT_QPA_PLATFORM, wayland;xcb
      # env = QT_QPA_PLATFORMTHEME, qt5ct
      # env = QT_QPA_PLATFORMTHEME, qt6ct
      # env = WLR_NO_HARDWARE_CURSORS, 1

      # --------- Screen tearing --------- #
      # env = WLR_DRM_NO_ATOMIC, 1

      # Set the backend for GDK (GIMP Drawing Kit) to support Wayland and X11
      "GDK_BACKEND,wayland,x11"

      # XWayland applications scaling fix (useful if you are using monitor scaling)
      # Refer to the Hyprland wiki for more details on configuration
      # toolkit-specific scale for GDK applications
      "GDK_SCALE,1"

      # Enable Wayland support for Electron applications
      "ELECTRON_ENABLE_WAYLAND,1"
      # Uncomment if using Electron applications older than version 28
      "ELECTRON_OZONE_PLATFORM_HINT,wayland"

      # Electron applications version 28 and above (may help with compatibility)
      # env = ELECTRON_OZONE_PLATFORM_HINT,auto

      # --------- NVIDIA --------- #
      # This is from Hyprland Wiki. Below will be activated nvidia gpu detected
      # See hyprland wiki https://wiki.hyprland.org/Nvidia/#environment-variables
      #env = LIBVA_DRIVER_NAME,nvidia
      #env = __GLX_VENDOR_LIBRARY_NAME,nvidia
      #env = NVD_BACKEND,direct

      # additional ENV's for nvidia. Caution, activate with care
      #env = GBM_BACKEND,nvidia-drm

      #env = __NV_PRIME_RENDER_OFFLOAD,1
      #env = __VK_LAYER_NV_optimus,NVIDIA_only
      #env = WLR_DRM_NO_ATOMIC,1

      # FOR VM and POSSIBLY NVIDIA
      # LIBGL_ALWAYS_SOFTWARE software mesa rendering
      #env = LIBGL_ALWAYS_SOFTWARE,1
      #env = WLR_RENDERER_ALLOW_SOFTWARE,1

      # nvidia firefox (for hardware acceleration on FF)?
      # check this post https://github.com/elFarto/nvidia-vaapi-driver#configuration
      #env = MOZ_DISABLE_RDD_SANDBOX,1
      #env = EGL_PLATFORM,wayland
    ];
  };
}
