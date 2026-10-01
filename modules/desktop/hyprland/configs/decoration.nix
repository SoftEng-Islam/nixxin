{
  config = {
    general = {
      gaps_in = 11;
      gaps_out = 11;
      border_size = 4;
      layout = "master"; # "master" or "dwindle";
      allow_tearing = true;
      resize_on_border = true;
      # Removed static col.active_border and col.inactive_border
      # to let Noctalia populate them cleanly below.
    };

    scrolling = {
      column_width = 1.0;
    };

    decoration = {
      rounding = 25;
      shadow = {
        enabled = false;
        range = 20;
        render_power = 1;
      };
      blur = {
        enabled = true;
        size = 4;
        passes = 2;
        new_optimizations = true;

        ignore_opacity = false;

        noise = 0.0117;
        contrast = 1.1;
        brightness = 1.0;

        xray = false;
        popups = false;
      };
    };
  };
}
