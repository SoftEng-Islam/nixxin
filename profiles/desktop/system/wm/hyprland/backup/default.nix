{ lib, settings, pkgs, ... }: {
  # swww = "swww img";
  # effect = "--transition-bezier .43,1.19,1,.4 --transition-fps 30 --transition-type grow --transition-pos 0.925,0.977 --transition-duration 2";
  imports = [
    # ./ags.nix
    # ./binds.nix
    # ./env.nix
    # # ./hyprlock.nix
    # ./plugins.nix
    # ./rules.nix
    # ./scripts.nix
    # ./settings.nix
  ];

  # Make stuff work on wayland
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    systemd.enable = true;
    plugins = with pkgs;
      [
        hyprlandPlugins.hyprbars
        hyprlandPlugins.hyprexpo
        hyprlandPlugins.hypr-dynamic-cursors
      ] ++ lib.optional (settings.themeDetails.bordersPlusPlus)
      hyprlandPlugins.borders-plus-plus;
  };
  wayland.windowManager.hyprland.settings = {
    env = [
      "XDG_CURRENT_DESKTOP,Hyprland"
      "XDG_SESSION_DEKSTOP,Hyprland"
      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
    ];

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
      "$mod, Q, killactive,"
      "$mod Shift , Q, exec, hyprctl kill" # Pick and kill a window
      "$mod, delete, exit,"
      "$mod, C, exec, code --password-store=gnome --enable-features=UseOzonePlatform --ozone-platform=wayland" # Launch VSCode (editor)
      "$mod, E, exec, nautilus --new-window" # Launch Nautilus (file manager)
      "$mod, Z, exec, Zed" # Launch Zed (editor)
      # "$mod Alt, E, exec, thunar" # Launch Thunar (file manager)
      "$mod, X, exec, gnome-text-editor --new-window" # Launch GNOME Text Editor
      # Launch GNOME Settings
      "Ctrl $mod, V, exec, pavucontrol" # Launch pavucontrol (volume mixer)
      "Ctrl Shift, Escape, exec, gnome-system-monitor" # Launch GNOME System monitor
      "Ctrl $mod, Slash, exec, pkill anyrun || anyrun" # Toggle fallback launcher: anyrun
      "$mod Alt, Slash, exec, pkill anyrun || fuzzel" # Toggle fallback launcher: fuzzel

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
      "$mod, S, togglespecialworkspace"
      "$mod SHIFT, S, movetoworkspacesilent, special"

      # Launcher
      # "$mod, A, exec, rofi -show drun -kb-cancel Super_L"
      "$mod SHIFT, A, exec, ags -t launcher"

      # Screenshot
      "$mod SHIFT, z, exec, wl-copy < $(grimshot --notify save area $XDG_PICTURES_DIR/Screenshots/$(TZ=utc date +'screenshot_%Y-%m-%d-%H%M%S.%3N.png'))"

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
      "$mod SHIFT, 1, movetoworkspace, 1"
      "$mod SHIFT, 2, movetoworkspace, 2"
      "$mod SHIFT, 3, movetoworkspace, 3"
      "$mod SHIFT, 4, movetoworkspace, 4"
      "$mod SHIFT, 5, movetoworkspace, 5"
      "$mod SHIFT, 6, movetoworkspace, 6"
      "$mod SHIFT, 7, movetoworkspace, 7"
      "$mod SHIFT, 8, movetoworkspace, 8"
      "$mod SHIFT, 9, movetoworkspace, 9"
      "$mod SHIFT, 0, movetoworkspace, 10"
      "$mod CTRL SHIFT, l, movetoworkspace, r+1"
      "$mod CTRL SHIFT, h, movetoworkspace, r-1"

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

      #/# bind = Super+Shift, Page_↑/↓,, # Window: move to workspace left/right
      "$mod Alt, Page_Down, movetoworkspace, +1"
      "$mod Alt, Page_Up, movetoworkspace, -1"
      "$mod Shift, Page_Down, movetoworkspace, +1"
      "$mod Shift, Page_Up, movetoworkspace, -1"
    ];
    bindr = [
      "Ctrl $mod , R, exec, killall ags ydotool; ags &"
      "Ctrl $mod Alt, R, exec, hyprctl reload; killall ags ydotool; ags &"
    ];
  };
  layerrule = [
    "blur, waybar"
    "blur, swaync-control-center"
    "blur, gtk-layer-shell"
    "xray 1, gtk-layer-shell"
    "xray 1, waybar"
    "ignorezero, waybar"
    "ignorezero, gtk-layer-shell"
    "ignorealpha 0.5, swaync-control-center"
  ];

  windowrule = [ "float,title:^(swayimg)(.*)$" ];
  windowrulev2 = [
    "keepaspectratio,class:^(firefox)$,title:^(Picture-in-Picture)$"
    "noborder,class:^(firefox)$,title:^(Picture-in-Picture)$"
    "pin,class:^(firefox)$,title:^(Firefox)$"
    "pin,class:^(firefox)$,title:^(Picture-in-Picture)$"
    "float,class:^(firefox)$,title:^(Firefox)$"
    "float,class:^(firefox)$,title:^(Picture-in-Picture)$"

    "float,class:^(floating)$,title:^(kitty)$"
    "size 50% 50%,class:^(floating)$,title:^(kitty)$"
    "center,class:^(floating)$,title:^(kitty)$"

    "float,class:^(moe.launcher.the-honkers-railway-launcher)$"
    "float,class:^(lutris)$"
    "size 1664 1005,class:^(lutris)$"
    "center,class:^(lutris)$"

    "fullscreen,class:^steam_appd+$"
    "monitor 0,class:^steam_app_d+$"
    "workspace 10,class:^steam_app_d+$"
  ];

  workspace =
    [ "special,gapsin:24,gapsout:64" "10,border:false,rounding:false" ];
  wayland.windowManager.hyprland.extraConfig = ''
      source=~/.cache/ignis/material/dark_colors-hyprland.conf
      env = QT_QPA_PLATFORM,wayland
      env = QT_QPA_PLATFORMTHEME,qt5ct
      env = GTK_THEME,Material

      exec-once = ignis init

    # Fullscreen screenshot
    # bindl= ,Print, exec, grim - | wl-copy # Screenshot >> clipboard
    bind = Ctrl, Print, exec, grim -g "$(slurp)" - | swappy -f - # Screen snip >> edit
    bind = $mod+Shift, S, exec, ~/.config/ags/scripts/grimblast.sh --freeze copy area # Screen snip
    bindl=,Print, exec, mkdir -p ~/Pictures/Screenshots && ~/.config/ags/scripts/grimblast.sh copysave screen ~/Pictures/Screenshots/Screenshot_"$(date '+%Y-%m-%d_%H.%M.%S')".png # Screenshot >> clipboard & file

    # will switch to a submap called resize
    bind=$mod,R,exec,echo -n "Resize" > /tmp/hypr_submap
    bind=$mod,R,submap,resize

    # will start a submap called "resize"
    submap=resize

    # sets repeatable binds for resizing the active window
    binde=,l,resizeactive,30 0
    binde=,h,resizeactive,-30 0
    binde=,k,resizeactive,0 -30
    binde=,j,resizeactive,0 30

    # use reset to go back to the global submap
    bind=,escape,exec,truncate -s 0 /tmp/hypr_submap
    bind=,escape,submap,reset

    # will reset the submap, meaning end the current one and return to the global one
    submap=reset

    bind=$mod,A,exec,echo -n "Launch" > /tmp/hypr_submap
    bind=$mod,A,submap,launch

    submap=launch
    bind=,F,exec,firefox
    bind=,D,exec,neovide --no-vsync

    bind=,escape,exec,truncate -s 0 /tmp/hypr_submap
    bind=,escape,submap,reset

    # Note, that after launching app submap immediately exits.
    bind=,F,exec,truncate -s 0 /tmp/hypr_submap
    bind=,F,submap,reset
    bind=,D,exec,truncate -s 0 /tmp/hypr_submap
    bind=,D,submap,reset

    # will reset the submap, meaning end the current one and return to the global one
    submap=reset
  '';
}