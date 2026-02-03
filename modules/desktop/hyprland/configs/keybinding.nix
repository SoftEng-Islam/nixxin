{ settings, pkgs, ... }:
# let socat = lib.getExe pkgs.socat; in
{
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland.settings = {
      # ---- Main Key ---- #
      "$main" = "SUPER";

      # noctalia-shell bindings
      "$ipc" = "qs -c noctalia-shell ipc call";

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
      bind = $main, ESCAPE, killactive
      # -------------------------- #
      # ---- $main + Alphabet ---- #
      # -------------------------- #
      #=> First Row:
      # bind = $main, Q, killactive,
      bind = $main, W, exec, ${settings.modules.desktop.xdg.defaults.webBrowser}
      bind = $main, E, exec,  GDK_BACKEND=wayland XDG_CURRENT_DESKTOP=GNOME ${pkgs.nautilus}/bin/nautilus --no-desktop --new-window > /dev/null 2>&1 & # Launch Nautilus (file manager)
      bind = $main, R, exec, ${pkgs.resources}/bin/resources
      bind = $main, T, exec, ${settings.modules.terminals.default.terminal.package}/bin/${settings.modules.terminals.default.terminal.name} # Launch (terminal)
      # bind = $main, Y, exec,
      # bind = $main, U, exec,
      # bind = $main, I, exec,
      bind = $main, O, togglesplit

      #=> Second Row:
      bind = $main, A, exec, pkill rofi || ${pkgs.rofi}/bin/rofi -show drun -show-icons
      # bind = $main, S, exec,
      # bind = $main, D, exec,
      bind = $main, F, fullscreen,
      #bind = $main Ctrl, F, 1, fullscreen 0
      #bind = $main Ctrl, F, 2, fullscreen 1
      #bind = $main Ctrl, F, 3, fullscreen 2
      # bind = $main, G, exec,
      # bind = $main, H, exec,
      # bind = $main, J, exec,
      # bind = $main, K, exec,
      bind = $main, L, exec, ${pkgs.hyprlock}/bin/hyprlock # Lock screen

      #=> Third Row:
      # bind = $main, Z, exec,
      bind = $main, X, exec, gnome-text-editor --new-window # Launch GNOME Text Editor
      bind = $main, C, exec, code # Launch VSCode (editor)
      # bind = $main, V, exec,
      # bind = $main, B, exec,
      # bind = $main, N, exec,
      # bind = $main, M, exec,

      # ---------------------- #
      # ---- $main + Ctrl ---- #
      # ---------------------- #
      bind = $main Ctrl, K, exec, hyprctl kill # Pick and kill an Active Window
      bind = $main Ctrl, L, exec, hyprctl dispatch exit # Logout
      bind = $main Ctrl, P, exec, ${pkgs.pavucontrol}/bin/pavucontrol # Launch pavucontrol (volume mixer)
      bind = $main Ctrl, T, exec, ${pkgs.kitty}/bin/kitty --class floating
      bind = $main Ctrl, R, exec, hyprctl reload && rm -rf ~/.cache/thumbnails/* && nautilus -q

      # --------------------- #
      # ---- $main + Alt ---- #
      # --------------------- #

      # ----------------------- #
      # ---- $main + Shift ---- #
      # ----------------------- #

      # ----------------------- #
      # ---- $main + F1:F12
      # ----------------------- #
      bind = $main, F1, exec, sudo toggleInternet
      bind = $main, F2, exec, run-gamemode
      bind = $main, F3, exec, run-blue-filter
      # bind = $main, F4, exec,
      # bind = $main, F5, exec,
      # bind = $main, F6, exec,

      # --------------------- #
      # ---- $main + Tag ---- #
      # --------------------- #
      #=> Launch Gnome Control Center
      # bind = $main, grave, exec, # $main + ~
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
      bind = $main ALT, F, togglefloating,
      bind = $main C, W, centerwindow, 1
      # bind = $main, TAB, focusmonitor, +1 # Move monitor focus.
      bind = $main, TAB, exec, qs ipc -c overview call overview toggle


      # In hyprland.conf
      bind = ALT, Tab, cyclenext, currentworkspace
      bind = ALT, SHIFT+Tab, cyclenext, prev, currentworkspace



      # Zoom
      # To zoom using Hyprland's built-in zoom utility
      # bind = $mod, mouse_down, exec, hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | awk '/^float.*/ {print $2 * 1.1}')
      # bind = $mod, mouse_up, exec, hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | awk '/^float.*/ {print $2 * 0.9}')

      # binde = $mod, equal, exec, hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | awk '/^float.*/ {print $2 * 1.1}')
      # binde = $mod, minus, exec, hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | awk '/^float.*/ {print $2 * 0.9}')
      # binde = $mod, KP_ADD, exec, hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | awk '/^float.*/ {print $2 * 1.1}')
      # binde = $mod, KP_SUBTRACT, exec, hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | awk '/^float.*/ {print $2 * 0.9}')

      # bind = $mod SHIFT, mouse_up, exec, hyprctl -q keyword cursor:zoom_factor 1
      # bind = $mod SHIFT, mouse_down, exec, hyprctl -q keyword cursor:zoom_factor 1
      # bind = $mod SHIFT, minus, exec, hyprctl -q keyword cursor:zoom_factor 1
      # bind = $mod SHIFT, KP_SUBTRACT, exec, hyprctl -q keyword cursor:zoom_factor 1
      # bind = $mod SHIFT, 0, exec, hyprctl -q keyword cursor:zoom_factor 1




      # -------------------- #
      # ---- Workspaces ---- #
      # -------------------- #
      #/# bind = Ctrl+Super, ←/→,, # Workspace: focus left/right
      bind = $main Ctrl, Right, workspace, +1
      bind = $main Ctrl, Left, workspace, -1

      # Switch workspaces with mainMod + [0-9]
      bind = $main, 1, workspace, 1
      bind = $main, 2, workspace, 2
      bind = $main, 3, workspace, 3
      bind = $main, 4, workspace, 4
      bind = $main, 5, workspace, 5
      bind = $main, 6, workspace, 6
      bind = $main, 7, workspace, 7
      bind = $main, 8, workspace, 8
      bind = $main, 9, workspace, 9
      bind = $main, 0, workspace, 10


      # Hyprtasking
      # "$mainMod, tab, hyprtasking:toggle, cursor"

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


      # -------------------------
      # window control
      # -------------------------
      # "$mainMod SHIFT, left, movewindow, l"
      # "$mainMod SHIFT, right, movewindow, r"
      # "$mainMod SHIFT, up, movewindow, u"
      # "$mainMod SHIFT, down, movewindow, d"
      # "$mainMod CTRL, left, resizeactive, -80 0"
      # "$mainMod CTRL, right, resizeactive, 80 0"
      # "$mainMod CTRL, up, resizeactive, 0 -80"
      # "$mainMod CTRL, down, resizeactive, 0 80"
      # "$mainMod ALT, left, moveactive,  -80 0"
      # "$mainMod ALT, right, moveactive, 80 0"
      # "$mainMod ALT, up, moveactive, 0 -80"
      # "$mainMod ALT, down, moveactive, 0 80"


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

      # ---- Screen Snip ---- #
      bind = Ctrl, Print, exec, grim -g "$(slurp)" - | swappy -f - # Screen snip >> edit
      bind = $main SHIFT, S, exec, mkdir -p ~/Pictures/Area && ${pkgs.grimblast}/bin/grimblast --notify --freeze copysave area ~/Pictures/Area/AreaShot_"$(date '+%Y-%m-%d_%H.%M.%S')".png # Screen snip

      # ---- Full Screenshot ---- #
      bindl= , print, exec, ${pkgs.grimblast}/bin/grimblast --notify --freeze --wait 1 copysave screen ~/Pictures/Screenshots/$(date +%Y-%m-%dT%H%M%S).png

      # bind = $main SHIFT, S, exec, grimblast --notify --freeze copysave area
      # bind = $main, S, exec, grimblast --notify --freeze copysave output
      # bind = ,PRINT, exec, grimblast --notify --freeze copysave output

      # You can Enable these if you want:
      # bindl= ,Print, exec, grim - | wl-copy # Screenshot >> clipboard
      # bind = Super+Shift,T,exec,grim -g "$(slurp $SLURP_ARGS)" "tmp.png" && tesseract -l eng "tmp.png" - | wl-copy && rm "tmp.png" # Screen snip to text >> clipboard
      # bind = Ctrl+Super+Shift,S,exec,grim -g "$(slurp $SLURP_ARGS)" "tmp.png" && tesseract "tmp.png" - | wl-copy && rm "tmp.png" # [hidden]

      # ---- Color Picker ---- #
      bind = Super+Shift, C, exec, hyprpicker -a # Pick color (Hex) >> clipboard

      # ---- audio volume bindings ---- #
      # binddel=,XF86AudioRaiseVolume,Raise volume 󰝝 ,exec,"${pkgs.wireplumber}/bin/wpctl}" set-volume @DEFAULT_AUDIO_SINK@ 5%+
      # binddel=,XF86AudioLowerVolume,Lower volume 󰝞 ,exec,"${pkgs.wireplumber}/bin/wpctl}" set-volume @DEFAULT_AUDIO_SINK@ 5%-
      # binddl=,XF86AudioMute,Toggle mute 󰝟 ,exec,"${pkgs.wireplumber}/bin/wpctl}" set-mute @DEFAULT_AUDIO_SINK@ toggle

      # ---- audio mic bindings ---- #
      # bindl=,XF86AudioMicMute, exec, "${pkgs.wireplumber}/bin/wpctl}" set-mute @DEFAULT_AUDIO_SOURCE@ toggle

      # Core binds
      bind = main, SPACE, exec, $ipc launcher toggle
      bind = main, S, exec, $ipc controlCenter toggle
      bind = main, comma, exec, $ipc settings toggle

      # Media keys
      bindel = , XF86AudioRaiseVolume, exec, $ipc volume increase
      bindel = , XF86AudioLowerVolume, exec, $ipc volume decrease
      bindl = , XF86AudioMute, exec, $ipc volume muteOutput
      bindel = , XF86MonBrightnessUp, exec, $ipc brightness increase
      bindel = , XF86MonBrightnessDown, exec, $ipc brightness decrease
    '';
  };
}
