{ pkgs, ... }:
{
  # Environment Variables
  # find /nix/store -name "something"
  environment = {
    variables = {
      _JAVA_AWT_WM_NONREPARENTING = "1";
      BEMENU_BACKEND = "wayland";
      CLUTTER_BACKEND = "wayland";
      ECORE_EVAS_ENGINE = "wayland_egl";
      ELM_ENGINE = "wayland_egl";
      GDK_BACKEND = "wayland";
      GST_PLUGIN_PATH = "/nix/store/01n130457xklp8b00ydwax22l0z3a62j-gst-plugins-base-1.24.3/lib/gstreamer-1.0:/nix/store/2dqc2lqhzacg2mb79677ik426a74axik-gst-plugins-good-1.24.3/lib/gstreamer-1.0:/nix/store/2syk2lmxxwx3cksqfjsb20zf5mdhrxir-gst-plugins-bad-1.24.3/lib/gstreamer-1.0:/nix/store/b88jfk9l912qgwmf98cp1024hmz05pd5-gst-plugins-ugly-1.24.3/lib/gstreamer-1.0:/nix/store/8llhhp5r452dkbz32kb7xxd1qpl5j433-gst-libav-1.24.3/lib/gstreamer-1.0";
      GTK_THEME = "Colloid-Dark";
      # HIP_VISIBLE_DEVICES = "0,2";
      # LIBGL_DRI3_ENABLE = "1";
      PKG_CONFIG_PATH = "/nix/store/bj5cf0ysvyjpqdwdjw7rqqd74g0wrdn3-glib-2.80.2-dev/lib/pkgconfig";
      # CARGO_PROFILE_DEV_BUILD_OVERRIDE_DEBUG = "true";
      RUST_BACKTRACE = "1";
      GLFW_IM_MODULE = "ibus";
      SDL_VIDEODRIVER = "wayland";

      swww = "swww img";
      effect = "--transition-bezier .43,1.19,1,.4 --transition-fps 30 --transition-type grow --transition-pos 0.925,0.977 --transition-duration 2";

      # Wine vars
      WINEESYNC = "1";
      WINEFSYNC = "1";

      # WLR_DRM_NO_ATOMIC = "1";
      # WLR_VSYNC = "1";
      XCURSOR_THEME = "Breeze_Light";
      XKB_DEFAULT_RULES = "evdev";
      # XMODIFIERS = "@im=fcitx";
      # SDL_IM_MODULE = "fcitx";
      # INPUT_METHOD = "fcitx";

      # Wayland vars
      WAYLAND = "1";
      ELECTRON_ENABLE_WAYLAND = "1";

      # XDG vars
      # export XDG_RUNTIME_DIR = "/run/user/$(id -u)";
      # XDG_RUNTIME_DIR = "/run/user/${toString config.users.users.softeng.uid}";
      XDG_RUNTIME_DIR = "/run/user/1000";
      XDG_SESSION_TYPE = "wayland";
      # XDG_CURRENT_DESKTOP = "Hyprland"; #"GNOME" or "Hyprland";

      # Hyprland vars

      # Qt vars
      # QT_WAYLAND_DISABLE_WINDOWDECORATION = "1"; // Enable if you are in Hyprland
      QT_QPA_PLATFORM = "wayland-egl";

      GI_TYPELIB_PATH =
        "${pkgs.glib}/lib/girepository-1.0:"
        + "${pkgs.gobject-introspection}/lib/girepository-1.0:"
        + "${pkgs.networkmanager}/lib/girepository-1.0:"
        + "${pkgs.gobject-introspection-unwrapped}/lib/girepository-1.0:"
        + "${pkgs.gst_all_1.gstreamer}/lib/girepository-1.0:"
        + "${pkgs.gst_all_1.gst-plugins-base}/lib/girepository-1.0:"
        + "${pkgs.gst_all_1.gst-plugins-ugly}/lib/girepository-1.0:"
        + "$GI_TYPELIB_PATH";

      # Colors #
      Black = "\033[30m";
      Red = "\033[31m";
      Green = "\033[32m";
      Yellow = "\033[33m";
      Blue = "\033[34m";
      Magenta = "\033[35m";
      Cyan = "\033[36m";
      White = "\033[37m";
      # Bright (Bold) Colors:
      B_Black = "\033[90m";
      B_Red = "\033[91m";
      B_Green = "\033[92m";
      B_Yellow = "\033[93m";
      B_Blue = "\033[94m";
      B_Magenta = "\033[95m";
      B_Cyan = "\033[96m";
      B_White = "\033[97m";

      # text format
      nc = "\033[0m";
      bold = "\033[1m";
      italic = "\033[3m";
      underline = "\033[4m";
      strikeThrough = "\033[9m";
      RESET = "\033[0m"; # Reset color

      # Unicode Characters
      heart = "\u2764"; # `echo -e "\u2764" Outputs a heart symbol (❤)`
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
