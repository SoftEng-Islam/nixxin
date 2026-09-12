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
      output.name = "HDMI-A-1";
      keyboard.layout = "us";
      cursor = {
        theme = settings.common.cursor.name;
        size = settings.common.cursor.size;
        path = "${settings.common.cursor.package}/share/icons";
      };
    };
  };
}
