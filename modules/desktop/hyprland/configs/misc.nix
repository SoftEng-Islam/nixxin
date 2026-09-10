{ settings, ... }:
{
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland = {
      settings.config = {
        render = {
          direct_scanout = 1;
          async_commit = true;
          cm_auto_hdr = 1;
          cm_enabled = true;
          cm_sdr_eotf = "gamma22";
          new_render_scheduling = true;
          use_fp16 = 2;
        };

        misc = {
          # ---- Display Features ---- #
          # controls the VRR (Adaptive Sync) of your monitors.
          #  0 - off
          #  1 - on
          #  2 - fullscreen only
          #  3 - fullscreen with video or game content
          vrr = 1; # type [0/1/2/3]

          disable_hyprland_logo = true;
          disable_splash_rendering = true;

          mouse_move_focuses_monitor = true;
        };

        debug = {
          damage_tracking = 2;
          disable_logs = false;
          enable_stdout_logs = true;
          gl_debugging = true;
        };

        ecosystem = {
          no_update_news = true;
          no_donation_nag = true;
        };
      };
    };
  };
}
