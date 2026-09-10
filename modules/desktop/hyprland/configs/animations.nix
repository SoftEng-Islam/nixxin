# This module configures animation settings for Hyprland, optimized for AMD Ryzen 5 3400G APU performance.
{ settings, ... }:
{
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland = {
      settings = {
        # hl.curve("nome", { type = "bezier", points = { {x1,y1}, {x2,y2} } })
        curve = [
          {
            _args = [
              "macOS"
              {
                type = "bezier";
                points = [
                  [
                    0.05
                    0.9
                  ]
                  [
                    0.1
                    1.05
                  ]
                ];
              }
            ];
          }
          {
            _args = [
              "macOSFade"
              {
                type = "bezier";
                points = [
                  [
                    0.4
                    0.0
                  ]
                  [
                    0.2
                    1.0
                  ]
                ];
              }
            ];
          }
          {
            _args = [
              "linear"
              {
                type = "bezier";
                points = [
                  [
                    0.0
                    0.0
                  ]
                  [
                    1.0
                    1.0
                  ]
                ];
              }
            ];
          }
        ];

        # hl.animation({ leaf = ..., enabled = ..., speed = ..., bezier = ..., style = ... })
        animation = [
          {
            leaf = "borderangle";
            enabled = true;
            speed = 100;
            bezier = "linear";
            style = "loop";
          }
          {
            leaf = "global";
            enabled = true;
            speed = 10;
            bezier = "macOS";
          }
          {
            leaf = "border";
            enabled = true;
            speed = 5;
            bezier = "macOSFade";
          }
          {
            leaf = "windows";
            enabled = true;
            speed = 5;
            bezier = "macOS";
            style = "popin 80%";
          }
          {
            leaf = "windowsIn";
            enabled = true;
            speed = 5;
            bezier = "macOS";
            style = "popin 80%";
          }
          {
            leaf = "windowsOut";
            enabled = true;
            speed = 4;
            bezier = "macOSFade";
            style = "popin 80%";
          }
          {
            leaf = "fadeIn";
            enabled = true;
            speed = 3;
            bezier = "macOSFade";
          }
          {
            leaf = "fadeOut";
            enabled = true;
            speed = 3;
            bezier = "macOSFade";
          }
          {
            leaf = "fade";
            enabled = true;
            speed = 3;
            bezier = "macOSFade";
          }
          {
            leaf = "layers";
            enabled = true;
            speed = 4;
            bezier = "macOS";
            style = "popin 80%";
          }
          {
            leaf = "layersIn";
            enabled = true;
            speed = 4;
            bezier = "macOS";
            style = "popin 80%";
          }
          {
            leaf = "layersOut";
            enabled = true;
            speed = 3;
            bezier = "macOSFade";
            style = "popin 80%";
          }
          {
            leaf = "fadeLayersIn";
            enabled = true;
            speed = 3;
            bezier = "macOSFade";
          }
          {
            leaf = "fadeLayersOut";
            enabled = true;
            speed = 3;
            bezier = "macOSFade";
          }
          {
            leaf = "workspaces";
            enabled = true;
            speed = 6;
            bezier = "macOS";
            style = "slide";
          }
          {
            leaf = "workspacesIn";
            enabled = true;
            speed = 6;
            bezier = "macOS";
            style = "slide";
          }
          {
            leaf = "workspacesOut";
            enabled = true;
            speed = 6;
            bezier = "macOS";
            style = "slide";
          }
        ];

        config = {
          animations = {
            enabled = true;
          };

          dwindle = {
            force_split = 0;
            preserve_split = true;
            default_split_ratio = 1.0;
            special_scale_factor = 0.8;
            split_width_multiplier = 1.0;
            use_active_for_splits = true;
          };

          master = {
            mfact = 0.5;
            orientation = "right";
            special_scale_factor = 0.8;
            new_status = "slave";
          };
        };
      };
    };
  };
}
