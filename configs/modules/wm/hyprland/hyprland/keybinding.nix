{ settings, ... }: {
  home-manager.users.${settings.username} = {
    wayland.windowManager.hyprland.settings = {
      # ---- Main Key
      "$main" = "SUPER";

      # Mouse bindings.
      bindm =
        [ "$main, mouse:272, movewindow" "$main, mouse:273, resizewindow" ];

      binde = [
        # ", XF86AudioRaiseVolume, exec, pulsemixer --change-volume +5"
        # ", XF86AudioLowerVolume, exec, pulsemixer --change-volume -5"
        ", XF86MonBrightnessUp, exec, brightnessctl s +5%"
        ", XF86MonBrightnessDown, exec, brightnessctl s 5%-"
        "$main ALT, k, exec, pulsemixer --change-volume +5"
        "$main ALT, j, exec, pulsemixer --change-volume -5"
      ];
      bind = [
        # -------------------------- #
        # ---- $main + Alphabet ---- #
        # -------------------------- #
        # ---- First Row ---- #
        "$main, Q, killactive,"
        "$main, W, exec, brave &"
        "$main, E, exec, nautilus --new-window" # Launch Nautilus (file manager)
        "$main, R, exec, resources &"
        "$main, T, exec, kitty" # Launch kitty (terminal)
        "$main, Y, exec, "
        "$main, U, exec, "
        "$main, I, exec, "
        "$main, O, togglesplit,"
        "$main, P, pseudo,"
        # ---- Second Row ---- #
        "$main, A, exec, "
        "$main, S, exec, "
        "$main, D, exec, fuzzel" # Toggle fallback launcher: fuzzel
        "$main, F, fullscreen, 0"
        "$main, G, exec, "
        "$main, H, exec, "
        "$main, J, exec, "
        "$main, K, exec, "
        "$main, L, exec, hyprlock" # Lock screen
        # ---- Third Row ---- #
        "$main, Z, exec, "
        "$main, X, exec, gnome-text-editor --new-window" # Launch GNOME Text Editor
        "$main, C, exec, code --password-store=gnome --enable-features=UseOzonePlatform --ozone-platform=wayland" # Launch VSCode (editor)
        "$main, V, exec, "
        "$main, B, exec, "
        "$main, N, exec, "
        "$main, M, exec, "

        # ---------------------- #
        # ---- $main + Ctrl ---- #
        # ---------------------- #
        "$main Ctrl, delete, exec, hyprctl dispatch exit" # Logout
        "$main Ctrl, exec, pavucontrol" # Launch pavucontrol (volume mixer)
        "$main Ctrl, exec, hyprctl kill" # Pick and kill an Active Window

        "$main SHIFT, Enter, exec, kitty --class floating"

        # Launch Gnome Control Center
        ''
          $main G, C, exec, XDG_CURRENT_DESKTOP="gnome" gnome-control-center
        ''

        # ---- Positioning Mode ---- #
        "$main SHIFT, F, fullscreen,"
        "$main T, F, togglefloating,"
        "$main C, W, centerwindow, 1"
        # Move monitor focus.
        "$main, TAB, focusmonitor, +1"

        # -------------------- #
        # ---- Workspaces ---- #
        # -------------------- #
        #/# bind = Ctrl+Super, ←/→,, # Workspace: focus left/right
        "$main Ctrl, Right, workspace, +1"
        "$main Ctrl, Left, workspace, -1"

        # Switch workspaces.
        "$main, 1,exec,hyprworkspace 1"
        "$main, 2,exec,hyprworkspace 2"
        "$main, 3,exec,hyprworkspace 3"
        "$main, 4,exec,hyprworkspace 4"
        "$main, 5,exec,hyprworkspace 5"
        "$main, 6,exec,hyprworkspace 6"
        "$main, 7,exec,hyprworkspace 7"
        "$main, 8,exec,hyprworkspace 8"
        "$main, 9,exec,hyprworkspace 9"
        "$main, 0,exec,hyprworkspace 10"

        # --------------------- #
        # ---- Move Window ---- #
        # --------------------- #
        # Move Active Window to a Workspace.
        "$main ALT, 1, movetoworkspace, 1"
        "$main ALT, 2, movetoworkspace, 2"
        "$main ALT, 3, movetoworkspace, 3"
        "$main ALT, 4, movetoworkspace, 4"
        "$main ALT, 5, movetoworkspace, 5"
        "$main ALT, 6, movetoworkspace, 6"
        "$main ALT, 7, movetoworkspace, 7"
        "$main ALT, 8, movetoworkspace, 8"
        "$main ALT, 9, movetoworkspace, 9"
        "$main ALT, 0, movetoworkspace, 10"

        # Move Active Window to a Workspace Silent.
        "$main SHIFT, 1, movetoworkspacesilent, 1"
        "$main SHIFT, 2, movetoworkspacesilent, 2"
        "$main SHIFT, 3, movetoworkspacesilent, 3"
        "$main SHIFT, 4, movetoworkspacesilent, 4"
        "$main SHIFT, 5, movetoworkspacesilent, 5"
        "$main SHIFT, 6, movetoworkspacesilent, 6"
        "$main SHIFT, 7, movetoworkspacesilent, 7"
        "$main SHIFT, 8, movetoworkspacesilent, 8"
        "$main SHIFT, 9, movetoworkspacesilent, 9"
        "$main SHIFT, 0, movetoworkspacesilent, 10"

        # Move Active Window to a workspace with Arrows.
        "$main Ctrl ALT, Right, movetoworkspace, r+1"
        "$main Ctrl ALT, Left, movetoworkspace, r-1"

        # ----------------- #
        # ---- Windows ---- #
        # ----------------- #
        # Move window Focus.
        "$main SHIFT, L, movefocus, l" # l: left
        "$main SHIFT, R, movefocus, r" # r: right
        "$main SHIFT, U, movefocus, u" # u: up
        "$main SHIFT, D, movefocus, d" # d: down

        # Swap Windows
        "$main CTRL, L, swapwindow, l" # l: left
        "$main CTRL, R, swapwindow, r" # r: right
        "$main CTRL, U, swapwindow, u" # u: up
        "$main CTRL, D, swapwindow, d" # d: down

        # ------------------------- #
        # ---- Mouse Shortcuts ---- #
        # ------------------------- #
        # Scroll through monitor workspaces with mod + scroll
        "$main, mouse_down, workspace, r-1"
        "$main, mouse_up, workspace, r+1"
        "$main, mouse:274, killactive," # $main + `Click On Mouse Scroll Button` to kill window

        # --------------------- #
        # ---- Media Stuff ---- #
        # --------------------- #
        # Music control
        "$main ALT, m, exec, pulsemixer --id $(pulsemixer --list-sources | cut -f3 | grep 'Default' | cut -d ',' -f 1 | cut -c 6-) --toggle-mute"
        "$main ALT, l, exec, hyprmusic next"
        "$main ALT, h, exec, hyprmusic previous"
        "$main ALT, p, exec, hyprmusic play-pause"
      ];
      bindr = [
        # Restart Ignis
        "Ctrl $main , R, exec, killall ignis ydotool; ignis init &"
        "Ctrl $main Alt, R, exec, hyprctl reload; killall ignis ydotool; ignis init &"
      ];
    };
    wayland.windowManager.hyprland.extraConfig = ''
      # ---- ignis ---- #
      bind = $main, A, exec, ignis toggle ignis_LAUNCHER
      bind = $main, M, exec, ignis toggle ignis_POWERMENU
      bind = ALT, F4, exec, ignis toggle ignis_POWERMENU

      # ---- ignis Recording ---- #
      bind = $main, R, exec, ~/.config/ignis/scripts/recording.py start
      bind = $main SHIFT, R, exec, ~/.config/ignis/scripts/recording.py continue
      bind = $main R, T, exec, ~/.config/ignis/scripts/recording.py stop
      bind = $main R SHIFT, T, exec, ~/.config/ignis/scripts/recording.py pause

      # ---- Screen snip ---- #
      bind = $main SHIFT, S, exec, mkdir -p ~/Pictures/Area && ~/.config/hypr/scripts/grimblast.sh --freeze copysave area ~/Pictures/Area/AreaShot_"$(date '+%Y-%m-%d_%H.%M.%S')".png # Screen snip
      bind = Ctrl, Print, exec, grim -g "$(slurp)" - | swappy -f - # Screen snip >> edit

      # ---- Full Screenshot ---- #
      bindl= ,Print, exec, ~/.config/hypr/scripts/grimblast.sh copysave screen ~/Pictures/Screenshots/Screenshot_"$(date '+%Y-%m-%d_%H.%M.%S')".png # Screenshot >> clipboard & file

      # bind = $mainMod SHIFT, S, exec, grimblast --notify --freeze copysave area
      # bind = $mainMod, S, exec, grimblast --notify --freeze copysave output
      # bind = ,PRINT, exec, grimblast --notify --freeze copysave output

      # You can Enable these if you want:
      # bindl= ,Print, exec, grim - | wl-copy # Screenshot >> clipboard
      # bind = Super+Shift,T,exec,grim -g "$(slurp $SLURP_ARGS)" "tmp.png" && tesseract -l eng "tmp.png" - | wl-copy && rm "tmp.png" # Screen snip to text >> clipboard
      # bind = Ctrl+Super+Shift,S,exec,grim -g "$(slurp $SLURP_ARGS)" "tmp.png" && tesseract "tmp.png" - | wl-copy && rm "tmp.png" # [hidden]

      # ---- Color picker ---- #
      bind = Super+Shift, C, exec, hyprpicker -a # Pick color (Hex) >> clipboard

      # Media binds
      bind = ,XF86AudioRaiseVolume, exec, pamixer -i 5 && ignis open ignis_OSD
      bind = ,XF86AudioLowerVolume, exec, pamixer -d 5 && ignis open ignis_OSD
      bind = ,XF86AudioMute, exec, pamixer -t && ignis open ignis_OSD
    '';
  };
}
