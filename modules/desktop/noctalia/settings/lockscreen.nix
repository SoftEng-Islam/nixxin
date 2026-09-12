{
  lockscreen = {
    enabled = true;
    blurred_desktop = true; # use a desktop snapshot as the lock screen background (requires wlr-screencopy)
    blur_intensity = 0.8; # lock screen background blur (0.0 = none, 1.0 = maximum)
    tint_intensity = 0.45; # surface-color tint over the lock screen background
    # wallpaper             = "";          # optional image path for the lock screen; empty uses the desktop wallpaper
    # monitors              = ["DP-1"];    # connectors that show the lock screen; empty shows all monitors, others stay black
  };

  lockscreen_widgets = {
    enabled = true;
    widget_order = [
      "clock_main"
      "clock_second"
    ];
    # ── Main Display (2560x1440) ──
    widget = {
      clock_main = {
        type = "clock";
        output = "HDMI-A-1";
        cx = 1280.0;
        cy = 140.0;
        scale = 1.5;
        rotation = 0.0;
        settings = {
          format = " {:%A %e, %B %m, %Y • %I:%M %p} ";
          background_opacity = 0.8;
        };
      };
      # ── Secondary Display (1920x1080) ──
      clock_second = {
        type = "clock";
        output = "DP-1";
        cx = 960.0;
        cy = 120.0;
        scale = 1.3;
        rotation = 0.0;
        settings = {
          format = " {:%A %e, %B %m, %Y • %I:%M %p} ";
          background_opacity = 0.8;
        };
      };
    };
  };

}
