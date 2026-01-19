{ settings, ... }: {
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland.settings = {
      env = [
        # Environment Variables Configuration
        # Environment variables. See https://wiki.hyprland.org/Configuring/Environment-variables/

        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"

        # Disable window decoration for Wayland Qt apps
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"

        # env = EDITOR,vim # Set the default editor (uncomment to use vim)

        # --------- Themes --------- #
        # Set the platform theme for Qt5 and Qt6 apps
        # env = QT_QPA_PLATFORM, wayland;xcb
        # env = QT_QPA_PLATFORMTHEME, qt5ct
        # env = QT_QPA_PLATFORMTHEME, qt6ct
        # env = WLR_NO_HARDWARE_CURSORS, 1

        # --------- Screen tearing --------- #
        # env = WLR_DRM_NO_ATOMIC, 1

        # Set the backend for GDK (GIMP Drawing Kit) to support Wayland and X11
        "GDK_BACKEND,wayland,x11"

        # ---- QT ---- #
        "DISABLE_QT5_COMPAT,0"
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "QT_QPA_PLATFORM,wayland;xcb"

        "MOZ_ENABLE_WAYLAND,1"
        "ANKI_WAYLAND,1"

        # "WLR_DRM_NO_ATOMIC,1"
        "WLR_BACKEND,vulkan"
        "WLR_RENDERER,vulkan"
        "WLR_NO_HARDWARE_CURSORS,1"

        "SDL_VIDEODRIVER,wayland"
        "CLUTTER_BACKEND,wayland"
        # "AQ_DRM_DEVICES,/dev/dri/card2:/dev/dri/card1" # CHANGEME: Related to the GPU

        "__GL_ALLOW_SOFTWARE,1"
        "MOZ_DISABLE_RDD_SANDBOX,1"
      ];
    };
  };
}
