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
        "${pkgs.grass-sass}/bin"
        "${pkgs.dart-sass}/bin"
        "${pkgs.sass}/bin"
        "${pkgs.yarn}/bin"
        # "${pkgs.rocmPackages.rocm-runtime}/bin:${pkgs.rocmPackages.hip-common}/bin:$PATH"

        "/run/current-system/sw/bin"
        "/run/wrappers/bin"
        "$HOME/.bun/bin"
        "$HOME/.local/bin"
        "$HOME/.local/share/pnpm"
        "$HOME/.npm-global/bin"
        "$HOME/.npm-packages/bin"
      ];

      # XDG_DATA_HOME = "$HOME/.local/share";
      # PASSWORD_STORE_DIR = "$HOME/.local/share/password-store";

      EDITOR = settings.global.EDITOR;
      VISUAL = settings.global.VISUAL;

      TERM = settings.global.TERM;
      BROWSER = settings.global.BROWSER;

      # Fixes `bad interpreter: Text file busy`
      # https://github.com/NixOS/nixpkgs/issues/314713
      UV_USE_IO_URING = "0";

      DIRENV_LOG_FORMAT = "";

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

      # Configures X keyboard settings.
      XKB_DEFAULT_RULES = "evdev";

      # Adjust rendering settings for OpenGL and graphics drivers.
      LIBGL_DRI3_ENABLE = "1";
      LIBGL_ALWAYS_INDIRECT = "1";

      # Set backend rendering to Wayland.
      SDL_VIDEODRIVER = "wayland";
      BEMENU_BACKEND = "wayland";
      GDK_BACKEND = "wayland";

      CLUTTER_BACKEND = "wayland";
      ELM_ENGINE = "wayland_egl";
      ECORE_EVAS_ENGINE = "wayland_egl";
      ELECTRON_ENABLE_WAYLAND = "1";

      # Configure the cursor theme and size for graphical sessions.
      XCURSOR = settings.global.cursor.name;
      XCURSOR_THEME = settings.global.cursor.name;
      XCURSOR_SIZE = toString settings.global.cursor.size;

      GTK_THEME = settings.global.gtk.theme;

      # FONTCONFIG_PATH = "/etc/fonts";
      # FONTCONFIG_FILE = "/etc/fonts/fonts.conf";

      # Enables portal-based access for apps like VSCode to integrate better with Wayland.
      GTK_USE_PORTAL = "1";

      # Java-specific setting for better compatibility with Wayland.
      _JAVA_AWT_WM_NONREPARENTING = "1";

      GDK_PIXBUF_MODULE_FILE =
        "${pkgs.librsvg}/lib/gdk-pixbuf-2.0/2.10.0/loaders.cache";

      MOZ_DBUS_REMOTE = "1";
      # Enables Wayland for Mozilla apps and EGL.
      MOZ_ENABLE_WAYLAND = "1";
      EGL_PLATFORM = "wayland";

      # QUOTING_STYLE = "literal";
      PKG_CONFIG_PATH = "$HOME/.nix-profile/lib/pkgconfig:/usr/lib/pkgconfig";
      # PKG_CONFIG_PATH = "$(nix eval nixpkgs.zlib.dev.outPath --raw)/lib/pkgconfig:$PKG_CONFIG_PATH";
      # PKG_CONFIG_PATH = "${pkgs.glib}/lib/pkgconfig";

    };
  };
}
