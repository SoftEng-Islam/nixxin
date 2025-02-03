{ settings, pkgs, ... }: {
  home-manager.users.${settings.users.selected.username} = {
    wayland.windowManager.hyprland.settings = {
      # ---- Main Key ---- #
      "$main" = "SUPER";

      # ---- Bind flags ---- #
      # => bind supports flags in this format:
      # bind[flags] = ...
      # => e.g.:
      # bindrl = MOD, KEY, exec, amongus
      # => Flags:
      # l -> locked, will also work when an input inhibitor (e.g. a lockscreen) is active.
      # r -> release, will trigger on release of a key.
      # o -> longPress, will trigger on long press of a key.
      # e -> repeat, will repeat when held.
      # n -> non-consuming, key/mouse events will be passed to the active window in addition to triggering the dispatcher.
      # m -> mouse.
      # t -> transparent, cannot be shadowed by other binds.
      # i -> ignore mods, will ignore modifiers.
      # s -> separate, will arbitrarily combine keys between each mod/key, see [Keysym combos](#keysym-combos) above.
      # d -> has description, will allow you to write a description for your bind.
      # p -> bypasses the app's requests to inhibit keybinds.
    };
    wayland.windowManager.hyprland.extraConfig = ''
      # -------------------------- #
      # ---- $main + Alphabet ---- #
      # -------------------------- #
      #=> First Row:
      bind = $main, Q, killactive
      bind = $main, W, exec, brave &
      bind = $main, E, exec, nautilus --new-window # Launch Nautilus (file manager)
      bind = $main, R, exec, ${pkgs.btop}/bin/btop
      bind = $main, T, exec, ${pkgs.kitty}/bin/kitty # Launch kitty (terminal)
      # bind = $main, Y, exec,
      # bind = $main, U, exec,
      # bind = $main, I, exec,
      bind = $main, O, togglesplit
      bind = $main, P, exec, ignis toggle ignis_POWERMENU
      # -------------
      #=> Second Row:
      # -------------
      bind = $main, A, exec, ignis toggle ignis_LAUNCHER
      # bind = $main, S, exec,
      # bind = $main, D, exec,
      bind = $main, F, fullscreen, 0
      # bind = $main, G, exec,
      # bind = $main, H, exec,
      # bind = $main, J, exec,
      # bind = $main, K, exec,
      bind = $main, L, exec, ${pkgs.hyprlock}/bin/hyprlock # Lock screen
      # -------------
      #=> Third Row:
      # -------------
      # bind = $main, Z, exec,
      bind = $main, X, exec, gnome-text-editor --new-window # Launch GNOME Text Editor
      bind = $main, C, exec, code --password-store=gnome --enable-features=UseOzonePlatform --ozone-platform=wayland # Launch VSCode (editor)
      # bind = $main, V, exec,
      # bind = $main, B, exec,
      # bind = $main, N, exec,
      # bind = $main, M, exec,

      # ---------------------- #
      # ---- $main + Ctrl ---- #
      # ---------------------- #
      bind = $main Ctrl, K, exec, hyprctl kill # Pick and kill an Active Window
      bind = $main Ctrl, L, exec, hyprctl dispatch exit # Logout
      bind = $main Ctrl, P, exec, pavucontrol # Launch pavucontrol (volume mixer)
      bind = $main Ctrl, T, exec, ${pkgs.kitty}/bin/kitty --class floating

      # --------------------- #
      # ---- $main + Alt ---- #
      # --------------------- #

      # ----------------------- #
      # ---- $main + Shift ---- #
      # ----------------------- #

      # --------------------- #
      # ---- $main + Tag ---- #
      # --------------------- #
      #=> Launch Gnome Control Center
      bind = $main, grave, exec, XDG_CURRENT_DESKTOP="gnome" gnome-control-center # $main + ~
      # bind = $main, , exec, # $main + <
      # bind = $main, , exec, # $main + >
      # bind = $main, , exec, # $main + /?
      # bind = $main, , exec, # $main + \|
      # bind = $main, , exec, # $main + ;:
      # bind = $main, , exec, # $main + '"
      # bind = $main, , exec, # $main + [
      # bind = $main, , exec, # $main + ]
      # bind = $main, , exec, # $main + `=`
      # bind = $main, , exec, # $main + `_`

      # ---- Positioning Mode ---- #
      bind = $main SHIFT, F, fullscreen,
      bind = $main T, F, togglefloating,
      bind = $main C, W, centerwindow, 1
      bind = $main, TAB, focusmonitor, +1 # Move monitor focus.

      # -------------------- #
      # ---- Workspaces ---- #
      # -------------------- #
      #/# bind = Ctrl+Super, ←/→,, # Workspace: focus left/right
      bind = $main Ctrl, Right, workspace, +1
      bind = $main Ctrl, Left, workspace, -1

      # Switch workspaces.
      bind = $main, 1,exec,hyprworkspace 1
      bind = $main, 2,exec,hyprworkspace 2
      bind = $main, 3,exec,hyprworkspace 3
      bind = $main, 4,exec,hyprworkspace 4
      bind = $main, 5,exec,hyprworkspace 5
      bind = $main, 6,exec,hyprworkspace 6
      bind = $main, 7,exec,hyprworkspace 7
      bind = $main, 8,exec,hyprworkspace 8
      bind = $main, 9,exec,hyprworkspace 9
      bind = $main, 0,exec,hyprworkspace 10

      # --------------------- #
      # ---- Move Window ---- #
      # --------------------- #
      # Move Active Window to a Workspace.
      bind = $main ALT, 1, movetoworkspace, 1
      bind = $main ALT, 2, movetoworkspace, 2
      bind = $main ALT, 3, movetoworkspace, 3
      bind = $main ALT, 4, movetoworkspace, 4
      bind = $main ALT, 5, movetoworkspace, 5
      bind = $main ALT, 6, movetoworkspace, 6
      bind = $main ALT, 7, movetoworkspace, 7
      bind = $main ALT, 8, movetoworkspace, 8
      bind = $main ALT, 9, movetoworkspace, 9
      bind = $main ALT, 0, movetoworkspace, 10

      # Move Active Window to a Workspace Silent.
      bind = $main SHIFT, 1, movetoworkspacesilent, 1
      bind = $main SHIFT, 2, movetoworkspacesilent, 2
      bind = $main SHIFT, 3, movetoworkspacesilent, 3
      bind = $main SHIFT, 4, movetoworkspacesilent, 4
      bind = $main SHIFT, 5, movetoworkspacesilent, 5
      bind = $main SHIFT, 6, movetoworkspacesilent, 6
      bind = $main SHIFT, 7, movetoworkspacesilent, 7
      bind = $main SHIFT, 8, movetoworkspacesilent, 8
      bind = $main SHIFT, 9, movetoworkspacesilent, 9
      bind = $main SHIFT, 0, movetoworkspacesilent, 10

      # Move Active Window to a workspace with Arrows.
      bind = $main Ctrl ALT, Right, movetoworkspace, r+1
      bind = $main Ctrl ALT, Left, movetoworkspace, r-1

      # --------------------------------------- #
      # ---- Window Shortcuts and Actions ---- #
      # --------------------------------------- #
      # ---- Move window Focus ---- #
      bind = $main , left , movefocus, l # l: left
      bind = $main , right , movefocus, r # r: right
      bind = $main , up , movefocus, u # u: up
      bind = $main , down , movefocus, d # d: down

      # ---- Swap Windows ---- #
      bind = $main Alt, left, swapwindow, l # l: left
      bind = $main Alt, right, swapwindow, r # r: right
      bind = $main Alt, up, swapwindow, u # u: up
      bind = $main Alt, down, swapwindow, d # d: down

      binde = , XF86MonBrightnessUp, exec, brightnessctl s +5%
      binde = , XF86MonBrightnessDown, exec, brightnessctl s 5%-

      # ------------------------- #
      # ---- Mouse Shortcuts ---- #
      # ------------------------- #
      # Scroll through monitor workspaces with mod + scroll
      bind = $main, mouse_down, workspace, r-1
      bind = $main, mouse_up, workspace, r+1
      bind = $main, mouse:274, killactive, # $main + `Click On Mouse Scroll Button` to kill window
      bindm = $main, mouse:272, movewindow # $main + `Left` Click
      bindm = $main, mouse:273, resizewindow # $main + `Right` Click

      # --------------- #
      # ---- ignis ---- #
      # --------------- #
      bind = $main, F1, exec, ignis toggle ignis_LAUNCHER
      bind = $main, F2, exec, ignis toggle ignis_POWERMENU
      bind = $main, F3, exec, ignis toggle ignis_POWERMENU
      #=> Restart Ignis
      bindr = $main Ctrl Alt, R, exec, hyprctl reload; killall ignis ydotool; ignis init &
      #=> ignis Recording
      bind = $main I, 1, exec, ~/.config/ignis/scripts/recording.py start
      bind = $main I, 2, exec, ~/.config/ignis/scripts/recording.py continue
      bind = $main I, 3, exec, ~/.config/ignis/scripts/recording.py stop
      bind = $main I, 4, exec, ~/.config/ignis/scripts/recording.py pause

      # ---- Screen snip ---- #
      bind = $main SHIFT, S, exec, mkdir -p ~/Pictures/Area && ~/.config/hypr/scripts/grimblast.sh --freeze copysave area ~/Pictures/Area/AreaShot_"$(date '+%Y-%m-%d_%H.%M.%S')".png # Screen snip
      bind = Ctrl, Print, exec, grim -g "$(slurp)" - | swappy -f - # Screen snip >> edit

      # ---- Full Screenshot ---- #
      # bindl= ,Print, exec, ~/.config/hypr/scripts/grimblast.sh copysave screen ~/Pictures/Screenshots/Screenshot_"$(date '+%Y-%m-%d_%H.%M.%S')".png # Screenshot >> clipboard & file
      bindl= ,print,exec,${pkgs.grimblast}/bin/grimblast --notify --freeze --wait 1 copysave area ~/Pictures/Screenshots/$(date +%Y-%m-%dT%H%M%S).png

      # bind = $mainMod SHIFT, S, exec, grimblast --notify --freeze copysave area
      # bind = $mainMod, S, exec, grimblast --notify --freeze copysave output
      # bind = ,PRINT, exec, grimblast --notify --freeze copysave output

      # You can Enable these if you want:
      # bindl= ,Print, exec, grim - | wl-copy # Screenshot >> clipboard
      # bind = Super+Shift,T,exec,grim -g "$(slurp $SLURP_ARGS)" "tmp.png" && tesseract -l eng "tmp.png" - | wl-copy && rm "tmp.png" # Screen snip to text >> clipboard
      # bind = Ctrl+Super+Shift,S,exec,grim -g "$(slurp $SLURP_ARGS)" "tmp.png" && tesseract "tmp.png" - | wl-copy && rm "tmp.png" # [hidden]

      # ---- Color picker ---- #
      bind = Super+Shift, C, exec, hyprpicker -a # Pick color (Hex) >> clipboard

      # --------------------- #
      # ---- Media binds ---- #
      # --------------------- #
      bind = ,XF86AudioRaiseVolume, exec, ${pkgs.pamixer}/bin/pamixer -i 5 && ignis open ignis_OSD
      bind = ,XF86AudioLowerVolume, exec, ${pkgs.pamixer}/bin/pamixer -d 5 && ignis open ignis_OSD
      bind = ,XF86AudioMute, exec, ${pkgs.pamixer}/bin/pamixer -t && ignis open ignis_OSD
    '';
  };
}
