{ config, lib, settings, pkgs, ... }: {
  # Environment Variables
  # find /nix/store -name "something"
  environment = {
    # localBinInPath = false;
    variables = {
      # Customizes the PATH environment variable to include directories for tools like Node.js,
      # Python, Sass, Yarn, Bun, and Ignis.
      PATH = lib.unique [
        "${pkgs.glib.dev}/bin"
        "${pkgs.nodejs}/bin"
        "${pkgs.nodePackages.npm}/bin"
        "${pkgs.python3}/bin"
        "${pkgs.sass}/bin"
        "${pkgs.yarn}/bin"
        #"$HOME/.cache/ignis/bin"
        "/run/current-system/sw/bin"
        "/run/wrappers/bin"
        "$HOME/.bun/bin"
        "$HOME/.local/bin"
        "$HOME/.local/share/pnpm"
        "$HOME/.npm-global/bin"
        "$HOME/.npm-packages/bin"
      ];

      EDITOR = settings.editor;
      VISUAL = settings.visual;

      TERM = settings.term;
      BROWSER = settings.browser;

      # Fixes `bad interpreter: Text file busy`
      # https://github.com/NixOS/nixpkgs/issues/314713
      UV_USE_IO_URING = "0";

      DIRENV_LOG_FORMAT = "";

      # auto-run programs using nix-index-database
      NIX_AUTO_RUN = "1";

      NVM_DIR = "$HOME/.nvm";
      PNPM_HOME = "/home/softeng/.local/share/pnpm";
      # Set the default editors for CLI-based tools.

      # Ignore commands that start with spaces and duplicates.
      HISTCONTROL = "ignoreboth";

      # Don't add certain commands to the history file.
      HISTIGNORE = "&:[bf]g:c:clear:history:exit:q:pwd:* --help";

      # Use custom `less` colors for `man` pages.
      LESS_TERMCAP_md = ''
        $(
              tput bold 2>/dev/null
              tput setaf 2 2>/dev/null
            )'';
      LESS_TERMCAP_me = "$(tput sgr0 2>/dev/null)";

      # Defines the system language.
      LANG = settings.locale;
      # Configures X keyboard settings.
      XKB_DEFAULT_RULES = "evdev";

      # GLFW_IM_MODULE = "ibus";
      # HIP_VISIBLE_DEVICES = "0,2";

      # Adjust rendering settings for OpenGL and graphics drivers.
      LIBGL_DRI3_ENABLE = "1";
      LIBGL_ALWAYS_INDIRECT = "1";

      # Adjusts DRM devices, vsync, and atomic modes.
      WLR_DRM_DEVICES = "/dev/dri/card1";
      WLR_DRM_NO_ATOMIC = "1";
      WLR_VSYNC = "1";

      # Simple DirectMedia Layer (SDL) library to use the Wayland display server as its video driver.
      # WAYLAND = "1";
      # WAYLAND_DISPLAY = "wayland-0";

      # Set backend rendering to Wayland.
      SDL_VIDEODRIVER = "wayland";
      BEMENU_BACKEND = "wayland";
      GDK_BACKEND = "wayland";

      CLUTTER_BACKEND = "wayland";
      ELM_ENGINE = "wayland_egl";
      ECORE_EVAS_ENGINE = "wayland_egl";
      ELECTRON_ENABLE_WAYLAND = "1";

      # Configure the cursor theme and size for graphical sessions.
      XCURSOR = settings.cursorTheme;
      XCURSOR_THEME = settings.cursorTheme;
      XCURSOR_SIZE = toString settings.cursorSize;

      # Optimize rendering and disable hardware cursors for Wayland-based compositors.
      WLR_RENDERER_ALLOW_SOFTWARE = "1"; # enable software rendering for wlroots
      WLR_NO_HARDWARE_CURSORS = "1"; # disable hardware cursors for wlroots

      GTK_THEME = settings.gtkTheme;

      # FONTCONFIG_PATH = "/etc/fonts";
      # FONTCONFIG_FILE = "/etc/fonts/fonts.conf";

      # Enables portal-based access for apps like VSCode to integrate better with Wayland.
      GTK_USE_PORTAL = "1";

      NIXOS_XDG_OPEN_USE_PORTAL = "1"; # needed to open apps after web login
      NIXOS_OZONE_WL = "1"; # Optional, hint electron apps to use wayland

      # Java-specific setting for better compatibility with Wayland.
      _JAVA_AWT_WM_NONREPARENTING = "1";

      GDK_PIXBUF_MODULE_FILE =
        "${pkgs.librsvg}/lib/gdk-pixbuf-2.0/2.10.0/loaders.cache";

      MOZ_DBUS_REMOTE = "1";
      # Enables Wayland for Mozilla apps and EGL.
      MOZ_ENABLE_WAYLAND = "1";
      EGL_PLATFORM = "wayland";

      # Enables support for non-free (proprietary) software in NixOS.
      NIXPKGS_ALLOW_UNFREE = "1";
      # NIXPKGS_ALLOW_INSECURE = "1";

      # Optimize Wine performance.
      WINEESYNC = "1";
      WINEFSYNC = "1";

      # Enables Rust backtraces for debugging.
      RUST_BACKTRACE = "1";
      CARGO_PROFILE_DEV_BUILD_OVERRIDE_DEBUG = "true";

      GOPROXY = "direct";
      BUN_INSTALL = "$HOME/.bun";

      QUOTING_STYLE = "literal";
      PKG_CONFIG_PATH = "$HOME/.nix-profile/lib/pkgconfig:/usr/lib/pkgconfig";
      # PKG_CONFIG_PATH = "$(nix eval nixpkgs.zlib.dev.outPath --raw)/lib/pkgconfig:$PKG_CONFIG_PATH";
      # PKG_CONFIG_PATH = "${pkgs.glib}/lib/pkgconfig";

      # Define paths for GStreamer plugins and GObject Introspection files, ensuring compatibility with various multimedia libraries.
      GST_PLUGIN_PATH =
        "${pkgs.gst_all_1.gst-plugins-base}/lib/gstreamer-1.0:${pkgs.gst_all_1.gst-plugins-good}/lib/gstreamer-1.0:${pkgs.gst_all_1.gst-plugins-bad}/lib/gstreamer-1.0:${pkgs.gst_all_1.gst-plugins-ugly}/lib/gstreamer-1.0:${pkgs.gst_all_1.gst-libav}/lib/gstreamer-1.0";
      GI_TYPELIB_PATH = "${pkgs.glib}/lib/girepository-1.0:"
        + "${pkgs.gobject-introspection}/lib/girepository-1.0:"
        + "${pkgs.networkmanager}/lib/girepository-1.0:"
        + "${pkgs.gobject-introspection-unwrapped}/lib/girepository-1.0:"
        + "${pkgs.gst_all_1.gstreamer}/lib/girepository-1.0:"
        + "${pkgs.gst_all_1.gst-plugins-base}/lib/girepository-1.0:"
        + "${pkgs.gst_all_1.gst-plugins-ugly}/lib/girepository-1.0:"
        + "$GI_TYPELIB_PATH";
    };
    # sessionVariables = { };
  };
}
