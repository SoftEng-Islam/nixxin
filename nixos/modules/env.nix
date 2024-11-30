{ pkgs, ... }: {
  # Environment Variables
  # find /nix/store -name "something"
  environment = {
    variables = {
      _JAVA_AWT_WM_NONREPARENTING = "1";
      # BEMENU_BACKEND = "wayland";
      CARGO_PROFILE_DEV_BUILD_OVERRIDE_DEBUG = "true";
      # CLUTTER_BACKEND = "wayland";
      # ECORE_EVAS_ENGINE = "wayland_egl";
      effect = "--transition-bezier .43,1.19,1,.4 --transition-fps 30 --transition-type grow --transition-pos 0.925,0.977 --transition-duration 2";
      # ELM_ENGINE = "wayland_egl";
      # GDK_BACKEND = "wayland,x11";
      GreenColor = "green";
      GST_PLUGIN_PATH = "/nix/store/01n130457xklp8b00ydwax22l0z3a62j-gst-plugins-base-1.24.3/lib/gstreamer-1.0:/nix/store/2dqc2lqhzacg2mb79677ik426a74axik-gst-plugins-good-1.24.3/lib/gstreamer-1.0:/nix/store/2syk2lmxxwx3cksqfjsb20zf5mdhrxir-gst-plugins-bad-1.24.3/lib/gstreamer-1.0:/nix/store/b88jfk9l912qgwmf98cp1024hmz05pd5-gst-plugins-ugly-1.24.3/lib/gstreamer-1.0:/nix/store/8llhhp5r452dkbz32kb7xxd1qpl5j433-gst-libav-1.24.3/lib/gstreamer-1.0";
      GTK_THEME = "Colloid-Dark";
      HIP_VISIBLE_DEVICES = "0,2";
      LIBGL_DRI3_ENABLE = "1";
      PKG_CONFIG_PATH = "/nix/store/bj5cf0ysvyjpqdwdjw7rqqd74g0wrdn3-glib-2.80.2-dev/lib/pkgconfig";
      # QT_QPA_PLATFORM = "wayland-egl";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      RUST_BACKTRACE = "1";
      # SDL_VIDEODRIVER = "wayland";
      swww = "swww img";
      # WAYLAND = "1";
      WINEESYNC = "1";
      WINEFSYNC = "1";
      # WLR_DRM_NO_ATOMIC = "1";
      WLR_VSYNC = "1";
      XCURSOR_THEME = "Breeze_Light";
      # XDG_CURRENT_DESKTOP = "Hyprland"; "GNOME" or "Hyprland";
      # XDG_RUNTIME_DIR=/tmp/$USER/.xdg;
      # XDG_SESSION_TYPE = "wayland";
      # XKB_DEFAULT_RULES = "evdev";
      GI_TYPELIB_PATH = "${pkgs.glib}/lib/girepository-1.0:"
        + "${pkgs.gobject-introspection}/lib/girepository-1.0:"
        + "${pkgs.networkmanager}/lib/girepository-1.0:"
        + "${pkgs.gobject-introspection-unwrapped}/lib/girepository-1.0:"
        + "${pkgs.gst_all_1.gstreamer}/lib/girepository-1.0:"
        + "${pkgs.gst_all_1.gst-plugins-base}/lib/girepository-1.0:"
        + "${pkgs.gst_all_1.gst-plugins-ugly}/lib/girepository-1.0:"
        + "$GI_TYPELIB_PATH";
    };
    sessionVariables = {
      # MOZ_DBUS_REMOTE = "1";
      MOZ_ENABLE_WAYLAND = "1"; # Ensure Firefox works well on Wayland
      WLR_NO_HARDWARE_CURSORS = 1; # IF your cursor becomes invisible
      GTK_USE_PORTAL = "1"; # Enables portal-based access for apps like VSCode on Wayland
      NIXOS_OZONE_WL = "1"; # Optional, hint electron apps to use wayland
    };
  };
}
