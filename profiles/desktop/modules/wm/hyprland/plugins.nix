{ config, mySettings, lib, ... }: {
  wayland.windowManager.hyprland.extraConfig = ''
    bind=$mod,grave,hyprexpo:expo, toggle
    plugin {
        hyprexpo {
            columns = 3
            gap_size = 5
            bg_col = rgb(${config.lib.stylix.colors.base00})
            workspace_method = center current # [center/first] [workspace] e.g. first 1 or center m+1

            enable_gesture = true # laptop touchpad
            gesture_fingers = 3  # 3 or 4
            gesture_distance = 300 # how far is the "max"
            gesture_negative = true # positive = swipe down. Negative = swipe up.
        }

        dynamic-cursors {
            enabled = true
            mode = stretch
            threshhold = 1
            stretch {
                limit = 1500
                # linear, quadratic, negative_quadratic
                function = linear
            }
            shake {
                enabled = true
                # use nearest-neighbour (pixelated) scaling when shaking
                # may look weird when effects are enabled
                nearest = true
                # controls how soon a shake is detected
                # lower values mean sooner
                threshold = 5.0
                # magnification level immediately after shake start
                base = 4.0
                # magnification increase per second when continuing to shake
                speed = 5.0
                # how much the speed is influenced by the current shake intensitiy
                influence = 0.0
                # maximal magnification the cursor can reach
                # values below 1 disable the limit (e.g. 0)
                limit = 0.0
                # time in millseconds the cursor will stay magnified after a shake has ended
                timeout = 2000
                # show cursor behaviour `tilt`, `rotate`, etc. while shaking
                effects = false
                # enable ipc events for shake
                # see the `ipc` section below
                ipc = false
            }
            hyprcursor {
                enabled = true
            }
        }
    }
  '' + lib.optionalString mySettings.themeDetails.bordersPlusPlus ''
    plugin {
      borders-plus-plus {
          add_borders = 2 # 0 - 9

          # you can add up to 9 borders
          col.border_1 = rgb(${config.lib.stylix.colors.base00})
          col.border_2 = rgb(${config.lib.stylix.colors.base00})

          # -1 means "default" as in the one defined in general:border_size
          border_size_1 = 3
          border_size_2 = 10

          natural_rounding = yes
      }
    }
  '';
  # plugin = {
  #   overview = {
  #     centerAligned = true;
  #     hideTopLayers = true;
  #     hideOverlayLayers = true;
  #     showNewWorkspace = true;
  #     exitOnClick = true;
  #     exitOnSwitch = true;
  #     drawActiveWorkspace = true;
  #     reverseSwipe = true;
  #   };
  #
  #   hyprbars = {
  #     bar_color = "rgb(2a2a2a)";
  #     bar_height = 28;
  #     col_text = "rgba(ffffffdd)";
  #     bar_text_size = 11;
  #     bar_text_font = "Ubuntu Nerd Font";
  #
  #     buttons = {
  #       button_size = 0;
  #       "col.maximize" = "rgba(ffffff11)";
  #       "col.close" = "rgba(ff111133)";
  #     };
  #   };
  # };

  #   "plugin:touch_gestures" = {
  #   sensitivity = 8.0;
  #   workspace_swipe_fingers = 3;
  #   long_press_delay = 400;
  #   edge_margin = 16;
  #   hyprgrass-bind = [
  #     ", edge:r:l, workspace, +1"
  #     ", edge:l:r, workspace, -1"
  #     ", edge:d:u, exec, my-shell toggle launcher"
  #   ];
  # };
}