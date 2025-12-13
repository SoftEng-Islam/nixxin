{ config, lib, settings, pkgs, ... }:

lib.mkIf (settings.modules.env.enable or true) {
  # Environment Variables
  # find /nix/store -name "something"
  environment = {
    # localBinInPath = false;
    variables = {
      DEVENVD_DISABLE_VERSION_CHECK = "1";
      DEVENVD_NO_ANALYTICS = "1";
      EDITOR = settings.common.EDITOR;
      VISUAL = settings.common.VISUAL;

      TERM = settings.common.TERM;
      BROWSER = settings.common.webBrowser;

      # Fixes `bad interpreter: Text file busy`
      # https://github.com/NixOS/nixpkgs/issues/314713
      UV_USE_IO_URING = "0";

      # Ignore commands that start with spaces and duplicates.
      HISTCONTROL = "ignoreboth";

      # vulkan-loader and libGL shared libs are necessary for hardware decoding
      LD_LIBRARY_PATH = lib.mkForce "${pkgs.lib.makeLibraryPath [
        pkgs.libGL
        pkgs.glslang
        pkgs.vulkan-headers
        pkgs.vulkan-loader
        pkgs.vulkan-validation-layers
        pkgs.vulkan-extension-layer
        pkgs.vulkan-tools
        pkgs.vulkan-tools-lunarg
        pkgs.vulkan-volk
      ]}";
      # VK_LAYER_PATH =
      #   "${pkgs.vulkan-validation-layers}/share/vulkan/explicit_layer.d";
      # VULKAN_SDK =
      #   "${pkgs.vulkan-validation-layers}/share/vulkan/explicit_layer.d";

      # LD_PRELOAD = "${pkgs.vulkan-loader}/lib/libvulkan.so";

      # Don't add certain commands to the history file.
      HISTIGNORE = "&:[bf]g:c:clear:history:exit:q:pwd:* --help";

      # Adjust rendering settings for OpenGL and graphics drivers.
      # LIBGL_DRI3_ENABLE = "1";
      # LIBGL_ALWAYS_INDIRECT = "1";

      # Set backend rendering to Wayland.
      # SDL_VIDEODRIVER = "wayland";
      # BEMENU_BACKEND = "wayland";
      # GDK_BACKEND = "wayland";
      # CLUTTER_BACKEND = "wayland";
      # ELM_ENGINE = "wayland_egl";
      # ECORE_EVAS_ENGINE = "wayland_egl";

      # ---- Electron ---- #
      # Enable Wayland support for Electron apps
      # ELECTRON_OZONE_PLATFORM_HINT = "auto";
      ELECTRON_ENABLE_WAYLAND = "1";
      NIXOS_OZONE_WL = "1"; # Optional, hint electron apps to use wayland

      # Configure the cursor theme and size for graphical sessions.
      XCURSOR = settings.common.cursor.name;
      XCURSOR_THEME = settings.common.cursor.name;
      XCURSOR_SIZE = toString settings.common.cursor.size;

      GTK_THEME = settings.common.gtk.GTK_THEME;

      # FONTCONFIG_PATH = "/etc/fonts";
      # FONTCONFIG_FILE = "/etc/fonts/fonts.conf";

      # Java-specific setting for better compatibility with Wayland.
      _JAVA_AWT_WM_NONREPARENTING = "1";

      MOZ_DBUS_REMOTE = "1";

      # Enables Wayland for Mozilla apps and EGL.
      MOZ_ENABLE_WAYLAND = "1";
      EGL_PLATFORM = "wayland";
    };
  };
}
