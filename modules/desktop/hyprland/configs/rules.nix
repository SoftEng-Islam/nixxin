{
  config = {
    layer_rule = [
      {
        # Noctalia v5
        name = "noctalia";
        match = {
          namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd)$";
        };
        no_anim = false;
        ignore_alpha = 0.5;
        blur = true;
        blur_popups = false;
      }
    ];
    windows_rule = [
      {
        match.class = "^(waydroid.*)$";
        fullscreen = true;
        no_blur = true;
      }
      {
        match.title = "^(Waydroid)$";
        fullscreen = true;
        no_blur = true;
      }
      {
        match.class = "mpv$";
        idle_inhibit = "focus";
      }
      {
        match = {
          class = "^(obsidian)$";
        };
        rounding = 0;
      }
    ];
  };
}
