{ settings, ... }:
{
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland = {
      settings = {
        config = {
          cursor = {
            enable_hyprcursor = true;
            no_hardware_cursors = 0;
          };

          general = {
            gaps_in = 10;
            gaps_out = 10;
            border_size = 3;
            layout = "dwindle";
            allow_tearing = true;
            col.active_border = {
              colors = [
                "primary"
                "surface"
                "surface"
                "primary"
              ];
              angle = 45;
            };
            col.inactive_border = {
              colors = [ "surface" ];
              angle = 0;
            };
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
              ignore_opacity = true;
              noise = 0.0117;
              contrast = 1.3;
              brightness = 1;
              xray = true;
            };
          };
        };
      };
    };
  };
}
