{ config, inputs, lib, settings, pkgs, ... }:
let
  # System and hardware configuration
  system = pkgs.stdenv.hostPlatform.system;
  nixos-opencl = inputs.nixos-opencl;
  mesa-drivers = nixos-opencl.packages.${system}.mesa;
  # Libraries we want available from nixpkgs
  libPath = pkgs.lib.makeLibraryPath [
    pkgs.vulkan-loader # libvulkan.so
    pkgs.vulkan-validation-layers # validation layer runtime
    pkgs.pipewire
    pkgs.sqlite
    # mesa-drivers
    pkgs.mesa
    pkgs.mesa_i686
  ];
  in lib.mkIf (settings.modules.env.enable or false) {
  # Environment Variables
  # find /nix/store -name "something"
  environment = {
    # localBinInPath = false;
    variables = {
      # ---- nixos-opencl Start ----
      # LD_LIBRARY_PATH = lib.mkForce "$LD_LIBRARY_PATH:${libPath}:/run/opengl-driver/lib";

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
      GDK_BACKEND = "wayland";
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
      MOZ_ENABLE_WAYLAND = "1";
      EGL_PLATFORM = "wayland";
    };
  };
}
