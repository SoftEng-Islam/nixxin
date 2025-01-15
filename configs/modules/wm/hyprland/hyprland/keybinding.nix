{ settings, ... }: {
  home-manager.users.${settings.username} = {
    wayland.windowManager.hyprland.settings = {
      "$mod" = "SUPER";
      # Mouse bindings.
      bindm = [ "$mod, mouse:272, movewindow" "$mod, mouse:273, resizewindow" ];
      binde = [
        ", XF86AudioRaiseVolume, exec, pulsemixer --change-volume +5"
        ", XF86AudioLowerVolume, exec, pulsemixer --change-volume -5"
        ", XF86MonBrightnessUp, exec, brightnessctl s +5%"
        ", XF86MonBrightnessDown, exec, brightnessctl s 5%-"
        "$mod ALT, k, exec, pulsemixer --change-volume +5"
        "$mod ALT, j, exec, pulsemixer --change-volume -5"
      ];
      bind = [
        # Window/Session actions.
        # "$mod, grave, overview:toggle, toggle" # can be: toggle, off/disable or on/enable
        "$mod, Q, killactive,"
        "$mod Shift , Q, exec, hyprctl kill" # Pick and kill a window
        "$mod Ctrl, delete, exec, hyprctl dispatch exit" # Logout
        "Ctrl Alt, delete, exec, reboot" # Reboot System
        "Ctrl Shift, Escape, exec, resources" # Launch GNOME System monitor

        "$mod, C, exec, code --password-store=gnome --enable-features=UseOzonePlatform --ozone-platform=wayland" # Launch VSCode (editor)
        "$mod, E, exec, nautilus --new-window" # Launch Nautilus (file manager)
        "$mod, X, exec, gnome-text-editor --new-window" # Launch GNOME Text Editor
        "$mod Ctrl, V, exec, pavucontrol" # Launch pavucontrol (volume mixer)

        # fuzzel Configuration File
        # XDG_CONFIG_HOME/fuzzel/fuzzel.ini
        "$mod,D, exec, fuzzel" # Toggle fallback launcher: fuzzel

        # Launch Gnome Control Center
        ''
          $mod, I, exec, XDG_CURRENT_DESKTOP="gnome" gnome-control-center
        ''

        # Positioning mode
        "$mod Alt, Space, togglefloating,"
        "$mod, F, fullscreen, 0"
        # "$mod, D, fullscreen, 1"
        "$mode SHIFT, F, fullscreen,"

        # Dwindle
        "$mod, O, togglesplit,"
        "$mod, P, pseudo,"

        # Lock screen
        "$mod, Escape, exec, hyprlock"

        # Application shortcuts.
        "$mod, T, exec, kitty" # Launch kitty (terminal)
        "$mod SHIFT, Return, exec, kitty --class floating"

        # Special workspace
        #"$mod, S, togglespecialworkspace"
        #"$mod SHIFT, S, movetoworkspacesilent, special"

        # Move window focus with vim keys.
        "$mod, h, movefocus, l"
        "$mod, l, movefocus, r"
        "$mod, k, movefocus, u"
        "$mod, j, movefocus, d"

        # Music control
        "$mod ALT, m, exec, pulsemixer --id $(pulsemixer --list-sources | cut -f3 | grep 'Default' | cut -d ',' -f 1 | cut -c 6-) --toggle-mute"
        ",XF86AudioMicMute, exec, pulsemixer --id $(pulsemixer --list-sources | cut -f3 | grep 'Default' | cut -d ',' -f 1 | cut -c 6-) --toggle-mute"
        ",XF86AudioMute, exec, pulsemixer --id $(pulsemixer --list-sinks | cut -f3 | grep 'Default' | cut -d ',' -f 1 | cut -c 6-) --toggle-mute"
        "$mod ALT, l, exec, hyprmusic next"
        "$mod ALT, h, exec, hyprmusic previous"
        "$mod ALT, p, exec, hyprmusic play-pause"

        # Swap windows with vim keys
        "$mod SHIFT, h, swapwindow, l"
        "$mod SHIFT, l, swapwindow, r"
        "$mod SHIFT, k, swapwindow, u"
        "$mod SHIFT, j, swapwindow, d"

        "$mod SHIFT, c, centerwindow, 1"

        # Move monitor focus.
        "$mod, TAB, focusmonitor, +1"

        #/# bind = Ctrl+Super, ←/→,, # Workspace: focus left/right
        "Ctrl $mod, Right, workspace, +1"
        "Ctrl $mod, Left, workspace, -1"

        # Switch workspaces.
        "$mod, 1,exec,hyprworkspace 1"
        "$mod, 2,exec,hyprworkspace 2"
        "$mod, 3,exec,hyprworkspace 3"
        "$mod, 4,exec,hyprworkspace 4"
        "$mod, 5,exec,hyprworkspace 5"
        "$mod, 6,exec,hyprworkspace 6"
        "$mod, 7,exec,hyprworkspace 7"
        "$mod, 8,exec,hyprworkspace 8"
        "$mod, 9,exec,hyprworkspace 9"
        "$mod, 0,exec,hyprworkspace 10"

        "$mod CTRL, h, workspace, r-1"
        "$mod CTRL, l, workspace, r+1"

        # Scroll through monitor workspaces with mod + scroll
        "$mod, mouse_down, workspace, r-1"
        "$mod, mouse_up, workspace, r+1"
        "$mod, mouse:274, killactive,"

        # Move active window to a workspace.
        "$mod ALT, 1, movetoworkspace, 1"
        "$mod ALT, 2, movetoworkspace, 2"
        "$mod ALT, 3, movetoworkspace, 3"
        "$mod ALT, 4, movetoworkspace, 4"
        "$mod ALT, 5, movetoworkspace, 5"
        "$mod ALT, 6, movetoworkspace, 6"
        "$mod ALT, 7, movetoworkspace, 7"
        "$mod ALT, 8, movetoworkspace, 8"
        "$mod ALT, 9, movetoworkspace, 9"
        "$mod ALT, 0, movetoworkspace, 10"

        # Move active window to a workspace silent.
        "$mod SHIFT, 1, movetoworkspacesilent, 1"
        "$mod SHIFT, 2, movetoworkspacesilent, 2"
        "$mod SHIFT, 3, movetoworkspacesilent, 3"
        "$mod SHIFT, 4, movetoworkspacesilent, 4"
        "$mod SHIFT, 5, movetoworkspacesilent, 5"
        "$mod SHIFT, 6, movetoworkspacesilent, 6"
        "$mod SHIFT, 7, movetoworkspacesilent, 7"
        "$mod SHIFT, 8, movetoworkspacesilent, 8"
        "$mod SHIFT, 9, movetoworkspacesilent, 9"
        "$mod SHIFT, 0, movetoworkspacesilent, 10"

        # Move active window to a workspace with Arrows.
        "$mod CTRL ALT, Up, movetoworkspace, r+1"
        "$mod CTRL ALT, Down, movetoworkspace, r-1"
        "$mod Ctrl ALT, Right, movetoworkspace, +1"
        "$mod Ctrl ALT, Left, movetoworkspace, -1"

        #/# bind = Super+Shift, Page_↑/↓,, # Window: move to workspace left/right
        "$mod Alt, Page_Down, movetoworkspace, +1"
        "$mod Alt, Page_Up, movetoworkspace, -1"
        "$mod Shift, Page_Down, movetoworkspace, +1"
        "$mod Shift, Page_Up, movetoworkspace, -1"
      ];
      bindr = [
        # Restart Ignis
        "Ctrl $mod , R, exec, killall ignis ydotool; ignis init &"
        "Ctrl $mod Alt, R, exec, hyprctl reload; killall ignis ydotool; ignis init &"
      ];
    };
    wayland.windowManager.hyprland.extraConfig = ''
      #  source=~/.cache/ignis/material/dark_colors-hyprland.conf

      # ignis
      bind = $mod, A, exec, ignis toggle ignis_LAUNCHER
      bind = $mod, M, exec, ignis toggle ignis_POWERMENU
      bind = ALT, F4, exec, ignis toggle ignis_POWERMENU
      # ---- ignis Recording ---- #
      bind = $mod, R, exec, ~/.config/ignis/scripts/recording.py start
      bind = $mod SHIFT, R, exec, ~/.config/ignis/scripts/recording.py continue
      bind = $mod R, T, exec, ~/.config/ignis/scripts/recording.py stop
      bind = $mod R SHIFT, T, exec, ~/.config/ignis/scripts/recording.py pause

      # ---- Screen snip ---- #
      bind = $mod SHIFT, S, exec, mkdir -p ~/Pictures/Area && ~/.config/hypr/scripts/grimblast.sh --freeze copysave area ~/Pictures/Area/AreaShot_"$(date '+%Y-%m-%d_%H.%M.%S')".png # Screen snip
      bind = Ctrl, Print, exec, grim -g "$(slurp)" - | swappy -f - # Screen snip >> edit


      # bind = $mainMod SHIFT, S, exec, grimblast --notify --freeze copysave area
      # bind = $mainMod, S, exec, grimblast --notify --freeze copysave output
      # bind = ,PRINT, exec, grimblast --notify --freeze copysave output

      # ---- Full Screenshot ---- #
      bindl= ,Print, exec, ~/.config/hypr/scripts/grimblast.sh copysave screen ~/Pictures/Screenshots/Screenshot_"$(date '+%Y-%m-%d_%H.%M.%S')".png # Screenshot >> clipboard & file

      # You can Enable these if you want:
      # bindl= ,Print, exec, grim - | wl-copy # Screenshot >> clipboard
      # bind = Super+Shift,T,exec,grim -g "$(slurp $SLURP_ARGS)" "tmp.png" && tesseract -l eng "tmp.png" - | wl-copy && rm "tmp.png" # Screen snip to text >> clipboard
      # bind = Ctrl+Super+Shift,S,exec,grim -g "$(slurp $SLURP_ARGS)" "tmp.png" && tesseract "tmp.png" - | wl-copy && rm "tmp.png" # [hidden]


      # ---- Color picker ---- #
      bind = Super+Shift, C, exec, hyprpicker -a # Pick color (Hex) >> clipboard
    '';
  };
}
