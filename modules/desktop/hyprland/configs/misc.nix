{ settings, ... }:
{
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland = {
      settings.config = {
        render = {
          direct_scanout = 1;
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
        };

        debug = {
          damage_tracking = 2;
        };

        ecosystem = {
          no_update_news = true;
          no_donation_nag = true;
        };
      };
    };
  };
}
