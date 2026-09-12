{
  wallpaper = {
    enabled = true;
    fill_mode = "crop"; # center | crop | fit | stretch | repeat | span
    fill_color = ""; # optional fallback/fill color: prefer a color role token; fixed hex also works
    transition = [
      "fade"
      "wipe"
      "disc"
      "stripes"
      "zoom"
      "honeycomb"
    ];
    transition_duration = 1500; # milliseconds
    edge_smoothness = 0.3;
    transition_on_startup = false; # animate the first wallpaper at shell startup (v4-style)
    directory = "~/Pictures/Wallpapers"; # empty = XDG Pictures directory
    directory_light = ""; # optional day-mode directory
    directory_dark = ""; # optional night-mode directory

    default = {
      path = ""; # optional initial/default wallpaper path
    };

    automation = {
      enabled = true;
      interval_seconds = 1800; # seconds between changes
      order = "random"; # random | alphabetical
      recursive = true; # include subdirectories when picking random wallpapers
    };
  };
}
