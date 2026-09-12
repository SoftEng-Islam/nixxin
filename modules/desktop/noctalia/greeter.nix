{
  settings,
  ...
}:
{
  programs.noctalia-greeter = {
    enable = true;
    settings = {
      # Session Name from `noctalia-greeter sessions` (picker label, not .desktop id).
      session.default = "Hyprland"; # Session selected on startup; overrides [session].last
      # Opens the password step for this account on startup.
      user.default = settings.user.username;
      appearance = {
        # Color scheme name: "Synced" (palette below or Sync sync.toml), or a builtin
        # like "Noctalia", "Catppuccin", .... Overrides last UI pick in sync.toml when set.
        scheme = "Synced"; # Color scheme: Synced or a built-in name such as Noctalia
        scheme_selector_position = "top-right"; # Scheme picker: top-right (default), top-left, bottom-left, bottom-right, or hidden
        # Password mask: "default" (filled circles) or "random" (cycled glyph shapes).
        password_style = "default"; # Password mask: default or random
        hide_logo = true; # Hide the Noctalia brand logo
        power_buttons_position = "bottom-right"; # Power controls: bottom-right (default), bottom-left, top-left, top-right, or hidden
        theme_mode = "dark"; # Theme mode for the Synced appearance, such as dark
        corner_radius_scale = 1.0; # Corner-radius scale for the Synced appearance
        font_family = "${settings.common.mainFont.name}";
        # Default wallpaper path, fill_mode, and fill_color; fill_mode accepts center, crop, fit, stretch, repeat, or span
        wallpaper = {
          # Absolute path, or color: #RRGGBB.
          # fill_mode: center | crop | fit | stretch | repeat | span
          # span projects one image across the logical multi-monitor layout; with one pinned output it behaves like crop.
          path = "${./greeted.png}";
          fill_mode = "crop";
          # fill_color = "#070722";
          # Optional per-connector wallpapers (overrides [appearance.wallpaper] for that output):
          # [appearance.wallpapers.DP-1]
          # path = "/var/lib/noctalia-greeter/wallpaper-DP-1.webp"
          # fill_mode = "crop"
        };
        palette = {
          primary = "#fff59b";
          on_primary = "#0e0e43";
          secondary = "#a9aefe";
          on_secondary = "#0e0e43";
          tertiary = "#9BFECE";
          on_tertiary = "#0e0e43";
          error = "#FD4663";
          on_error = "#0e0e43";
          surface = "#070722";
          on_surface = "#f3edf7";
          surface_variant = "#11112d";
          on_surface_variant = "#7c80b4";
          outline = "#21215F";
          shadow = "#070722";
          hover = "#9BFECE";
          on_hover = "#0e0e43";
        };
      };
      keyboard = {
        layout = "us";
        variant = ",qwertz";
        options = "grp:alt_shift_toggle";
        # Start with Num Lock locked (default true if omitted).
        numlock = true;
      };
      auth = {
        # Allow empty password submit (fprintd / smartcard PAM). Default false.
        allow_empty_password = false;
        # Seconds to wait for each greetd reply (0-3600). 0 disables the watchdog.
        request_timeout = 60;
      };
      # Seconds with no input before blanking outputs; 0 disables (range 0-86400).
      idle.timeout = 300;
      cursor = {
        theme = settings.common.cursor.name;
        size = settings.common.cursor.size;
        path = "${settings.common.cursor.package}/share/icons";
      };
      output = {
        # Pin the greeter to one connector; omit to mirror on every monitor.
        # List names with: noctalia-greeter outputs
        name = "HDMI-A-1";
        # Multi-monitor positions (logical pixels). Overrides Sync layout in sync.toml when set.
        layout = "HDMI-A-1:0,0; DP-1:2560,0";
        # Preferred DRM mode size in pixels (both required if set).
        # width = 5120;
        # height = 2160;
        # Per-connector DRM transform. Overrides Sync transforms in sync.toml when set.
        # Tokens: normal/0/none, 90, 180, 270, flipped, flipped-90, flipped-180, flipped-270
        # transforms = "DP-1:normal; DP-2:normal";
        # Per-connector scale matching the session (logical layout coords). Overrides Sync scales when set.
        # Distinct from global `scale` below, which forces one scale on every output.
        # scales = "DP-1:1; DP-2:1";
        # Manual UI scale for all outputs; omit or invalid -> per-output scales, else auto from display geometry.
        # scale = 1.5;
      };
    };
  };
}
