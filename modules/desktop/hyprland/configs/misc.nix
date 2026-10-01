{
  config = {
    misc = {
      # ---- Display Features ---- #
      # controls the VRR (Adaptive Sync) of your monitors.
      #  0 - off
      #  1 - on
      #  2 - fullscreen only
      #  3 - fullscreen with video or game content
      vrr = 3; # type [0/1/2/3]

      disable_hyprland_logo = true;
      disable_splash_rendering = true;

      mouse_move_focuses_monitor = true;
    };

    debug = {
      disable_logs = true;
      enable_stdout_logs = false;
      gl_debugging = false;
    };

    ecosystem = {
      no_update_news = true;
      no_donation_nag = true;
    };
  };
}
