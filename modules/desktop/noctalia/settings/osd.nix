{
  osd = {
    position = "center"; # top_right | top_left | top_center | bottom_right | bottom_left | bottom_center | center_right | center_left
    position_vertical = "center"; # same options; used when orientation = "vertical"
    orientation = "horizontal"; # horizontal | vertical (volume/brightness sliders only; text popups stay horizontal)
    scale = 1.15; # OSD size multiplier applied on top of accessibility.ui_scale
    background_opacity = 1; # background opacity of OSD popups
    offset_x = 0; # absolute horizontal margin from the screen edge
    offset_y = 0; # absolute vertical margin from the screen edge
    # monitors = ["DP-1"]               # connector names; omit or leave empty for all monitors
    kinds = {
      volume = true; # master volume OSD toggle
      volume_output = true; # output (speaker) volume; requires volume = true
      volume_input = true; # input (microphone) volume; requires volume = true
      brightness = true; # display brightness changes
      wifi = true; # Wi-Fi toggle
      bluetooth = true; # Bluetooth toggle
      power_profile = true; # power profile changes
      caffeine = true; # idle inhibitor (caffeine) toggle
      nightlight = true; # night light toggle
      dnd = true; # Do Not Disturb toggle
      lock_keys = true; # Caps/Num/Scroll Lock changes; disable to stop polling when no widget uses them
      keyboard_layout = true; # input keyboard layout changes
      privacy = true; # microphone/camera/screen-share capture changes
    };
  };
}
