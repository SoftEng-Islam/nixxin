{
  idle = {
    # fade a fullscreen surface-color overlay in over this many seconds, then run `command`.
    # Use 0 for immediate commands with no overlay. Input during the fade cancels.
    # pre_action_fade_seconds = 2.0;

    behavior = {
      lock = {
        timeout = 600;
        action = "lock";
        enabled = true;
      };
      screen-off = {
        timeout = 660;
        action = "screen_off";
        enabled = true;
      };
    };
  };
}
