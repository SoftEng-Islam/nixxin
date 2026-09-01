{ settings, ... }: {
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland.settings = {
      env = [
        # ╔═══════════════════════════════════════════════════════════════╗
        # ║            Environment Variables Configuration                ║
        # ║        Optimized for AMD Ryzen 5 3400G APU (Vega 11)         ║
        # ╚═══════════════════════════════════════════════════════════════╝

        # ---- Wayland Session ---- #
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"

        # ---- AMD GPU Configuration ---- #
        # Force AMD GPU for all graphics operations
        "WLR_RENDERER,vulkan"
        "WLR_NO_HARDWARE_CURSORS,1"

        # Mesa/RADV driver optimizations for AMD
        "RADV_PERFTEST,gpl,nggc"      # Enable NGG culling & graphics pipeline library
        "AMD_VULKAN_ICD,RADV"         # Use RADV (Mesa) driver

        # ---- Qt/GTK Wayland Support ---- #
        "QT_QPA_PLATFORM,wayland;xcb"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "GDK_BACKEND,wayland,x11"
        "SDL_VIDEODRIVER,wayland"
        "CLUTTER_BACKEND,wayland"

        # ---- Cursor & Scaling ---- #
        "XCURSOR_SIZE,24"
        "XCURSOR_THEME,Adwaita"

        # ---- Performance hints ---- #
        # Use WLR_DRM_NO_MODIFIERS=1 only if you experience graphical glitches
        # "WLR_DRM_NO_MODIFIERS,1"
      ];
    };
  };
}
