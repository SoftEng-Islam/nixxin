{ settings, ... }:
{
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland = {
      settings = {
        config = {
          general = {
            gaps_in = 10;
            gaps_out = 10;
            border_size = 3;
            layout = "dwindle";
            allow_tearing = true;
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
              ignore_opacity = true;
              noise = 0.0117;
              contrast = 1.3;
              brightness = 1;
              xray = true;
            };
          };
        };
      };

      extraConfig = ''
        local noctalia = require("noctalia")
        noctalia.apply_theme()

        -- Custom gradient using Noctalia color table
        hl.config({
          general = {
            col = {
              active_border = {
                colors = {
                  noctalia.colors.primary,
                  noctalia.colors.surface,
                  noctalia.colors.surface,
                  noctalia.colors.primary,
                },
                angle = 45,
              },
              inactive_border = {
                colors = {
                  noctalia.colors.surface,
                },
                angle = 0,
              },
            },
          },
        })
      '';
    };
  };
}
