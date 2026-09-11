{
  settings,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib.generators) mkLuaInline;

  # bind with SUPER (Lua variable `mod`, defined in default.nix)
  m = keys: dsp: {
    _args = [
      (mkLuaInline "mod .. \" + ${keys}\"")
      (mkLuaInline dsp)
    ];
  };

  # bind with fixed keys
  k = keys: dsp: {
    _args = [
      keys
      (mkLuaInline dsp)
    ];
  };

  defaultFileManager = settings.modules.desktop.file_manager.default;
  fileManagerExec =
    if (defaultFileManager == "nautilus") then
      "GDK_BACKEND=wayland XDG_CURRENT_DESKTOP=GNOME ${pkgs.nautilus}/bin/nautilus --no-desktop --new-window > /dev/null 2>&1 &"
    else if (defaultFileManager == "nemo") then
      "${pkgs.nemo}/bin/nemo"
    else if (defaultFileManager == "thunar") then
      "${pkgs.xfce.thunar}/bin/thunar"
    else if (defaultFileManager == "dolphin") then
      "${pkgs.kdePackages.dolphin}/bin/dolphin"
    else
      null;

in
{
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland.settings = {
      bind = [
        # -------------------------- #
        # ---- $main + Alphabet ---- #
        # -------------------------- #
        (m "ESCAPE" "hl.dsp.window.close()")
        (m "W" "hl.dsp.exec_cmd(\"${settings.modules.desktop.xdg.defaults.webBrowser}\")")

        # File Manager
        (m "E" "hl.dsp.exec_cmd(\"${fileManagerExec}\")")

        # PC Resources monitor
        (m "R" "hl.dsp.exec_cmd(\"${pkgs.mission-center}/bin/missioncenter\")")

        # Terminal
        (m "T" "hl.dsp.exec_cmd(\"${settings.modules.terminals.default.terminal.package}/bin/${settings.modules.terminals.default.terminal.name}\")")
        (m "O" "hl.dsp.layout(\"togglesplit\")")

        # Second Row
        (m "A" "hl.dsp.exec_cmd(\"noctalia msg panel-toggle launcher\")")
        (m "F" "hl.dsp.window.fullscreen()")
        (m "L" "hl.dsp.exec_cmd(\"noctalia msg screen-lock\")")

        # Third Row
        (m "X" "hl.dsp.exec_cmd(\"${pkgs.zed-editor}/bin/zeditor\")")
        (m "C" "hl.dsp.exec_cmd(\"code\")")

        # ---------------------- #
        # ---- $main + Ctrl ---- #
        # ---------------------- #
        (m "CTRL + K" "hl.dsp.exec_cmd(\"hyprctl kill\")")
        (m "CTRL + L" "hl.dsp.exit()")
        (m "CTRL + P" "hl.dsp.exec_cmd(\"${pkgs.pavucontrol}/bin/pavucontrol\")")
        (m "CTRL + R" "hl.dsp.exec_cmd(\"hyprctl reload && rm -rf ~/.cache/thumbnails/* && nautilus -q\")")

        # ----------------------- #
        # ---- $main + F1:F12 ---- #
        # ----------------------- #
        (m "F1" "hl.dsp.exec_cmd(\"sudo toggleInternet\")")
        (m "F2" "hl.dsp.exec_cmd(\"run-gamemode\")")
        (m "F3" "hl.dsp.exec_cmd(\"run-blue-filter\")")
        (m "F4" "hl.dsp.exec_cmd(\"noctalia msg panel-toggle session\")")
        (m "F5" "hl.dsp.exec_cmd(\"waydroid session stop && notify-send \\\"Waydroid Is Closed.\\\"\")")

        # ------------------------ #
        # ---- Positioning Mode ---- #
        # ------------------------ #
        (m "ALT + F" "hl.dsp.window.float()")
        (m "CTRL + W" "hl.dsp.exec_cmd(\"hyprctl dispatch centerwindow 1\")")
        (m "TAB" "hl.dsp.exec_cmd(\"qs ipc -c overview call overview toggle\")")

        # Fixed Alt+Tab cycling (calling hl.dispatch directly)
        (k "ALT + TAB" "hl.dispatch(\"cyclenext\", \"currentworkspace\")")
        (k "ALT + SHIFT + TAB" "hl.dispatch(\"cyclenext\", \"prev currentworkspace\")")

        # -------------------- #
        # ---- Workspaces ---- #
        # -------------------- #
        (m "CTRL + Right" "hl.dsp.focus({ workspace = \"+1\" })")
        (m "CTRL + Left" "hl.dsp.focus({ workspace = \"-1\" })")

        (m "1" "hl.dsp.focus({ workspace = \"1\" })")
        (m "2" "hl.dsp.focus({ workspace = \"2\" })")
        (m "3" "hl.dsp.focus({ workspace = \"3\" })")
        (m "4" "hl.dsp.focus({ workspace = \"4\" })")
        (m "5" "hl.dsp.focus({ workspace = \"5\" })")
        (m "6" "hl.dsp.focus({ workspace = \"6\" })")
        (m "7" "hl.dsp.focus({ workspace = \"7\" })")
        (m "8" "hl.dsp.focus({ workspace = \"8\" })")
        (m "9" "hl.dsp.focus({ workspace = \"9\" })")
        (m "0" "hl.dsp.focus({ workspace = \"10\" })")

        # --------------------- #
        # ---- Move Window ---- #
        # --------------------- #
        # Move Active Window to a Workspace (follow = true)
        (m "ALT + 1" "hl.dsp.window.move({ workspace = \"1\", follow = true })")
        (m "ALT + 2" "hl.dsp.window.move({ workspace = \"2\", follow = true })")
        (m "ALT + 3" "hl.dsp.window.move({ workspace = \"3\", follow = true })")
        (m "ALT + 4" "hl.dsp.window.move({ workspace = \"4\", follow = true })")
        (m "ALT + 5" "hl.dsp.window.move({ workspace = \"5\", follow = true })")
        (m "ALT + 6" "hl.dsp.window.move({ workspace = \"6\", follow = true })")
        (m "ALT + 7" "hl.dsp.window.move({ workspace = \"7\", follow = true })")
        (m "ALT + 8" "hl.dsp.window.move({ workspace = \"8\", follow = true })")
        (m "ALT + 9" "hl.dsp.window.move({ workspace = \"9\", follow = true })")
        (m "ALT + 0" "hl.dsp.window.move({ workspace = \"10\", follow = true })")

        # Move Active Window to a Workspace Silent (follow = false)
        (m "SHIFT + 1" "hl.dsp.window.move({ workspace = \"1\", follow = false })")
        (m "SHIFT + 2" "hl.dsp.window.move({ workspace = \"2\", follow = false })")
        (m "SHIFT + 3" "hl.dsp.window.move({ workspace = \"3\", follow = false })")
        (m "SHIFT + 4" "hl.dsp.window.move({ workspace = \"4\", follow = false })")
        (m "SHIFT + 5" "hl.dsp.window.move({ workspace = \"5\", follow = false })")
        (m "SHIFT + 6" "hl.dsp.window.move({ workspace = \"6\", follow = false })")
        (m "SHIFT + 7" "hl.dsp.window.move({ workspace = \"7\", follow = false })")
        (m "SHIFT + 8" "hl.dsp.window.move({ workspace = \"8\", follow = false })")
        (m "SHIFT + 9" "hl.dsp.window.move({ workspace = \"9\", follow = false })")
        (m "SHIFT + 0" "hl.dsp.window.move({ workspace = \"10\", follow = false })")

        # Move Active Window to a workspace with Arrows.
        (m "CTRL + ALT + Right" "hl.dsp.window.move({ workspace = \"r+1\", follow = true })")
        (m "CTRL + ALT + Left" "hl.dsp.window.move({ workspace = \"r-1\", follow = true })")

        # --------------------------------------- #
        # ---- Window Shortcuts and Actions ---- #
        # --------------------------------------- #
        # Move window Focus
        (m "left" "hl.dsp.focus({ direction = \"left\" })")
        (m "right" "hl.dsp.focus({ direction = \"right\" })")
        (m "up" "hl.dsp.focus({ direction = \"up\" })")
        (m "down" "hl.dsp.focus({ direction = \"down\" })")

        # Swap Windows
        (m "ALT + left" "hl.dsp.window.swap({ direction = \"left\" })")
        (m "ALT + right" "hl.dsp.window.swap({ direction = \"right\" })")
        (m "ALT + up" "hl.dsp.window.swap({ direction = \"up\" })")
        (m "ALT + down" "hl.dsp.window.swap({ direction = \"down\" })")

        # ------------------------- #
        # ---- Mouse Shortcuts ---- #
        # ------------------------- #
        (m "mouse_down" "hl.dsp.focus({ workspace = \"r-1\" })")
        (m "mouse_up" "hl.dsp.focus({ workspace = \"r+1\" })")
        (m "mouse:274" "hl.dsp.window.close()")
        (m "mouse:272" "hl.dsp.window.drag()")
        (m "mouse:273" "hl.dsp.window.resize()")

        # ------------------------- #
        # ---- Screen Snip -------- #
        # ------------------------- #
        (k "CTRL + Print" "hl.dsp.exec_cmd(\"grim -g \\\"$(slurp)\\\" - | swappy -f -\")")
        (m "SHIFT + S" "hl.dsp.exec_cmd(\"mkdir -p ~/Pictures/Area && ${pkgs.grimblast}/bin/grimblast --notify --freeze copysave area ~/Pictures/Area/AreaShot_\\\"$(date '+%Y-%m-%d_%H.%M.%S')\\\".png\")")
        (k "print" "hl.dsp.exec_cmd(\"${pkgs.grimblast}/bin/grimblast --notify --freeze --wait 1 copysave screen ~/Pictures/Screenshots/$(date +%Y-%m-%dT%H%M%S).png\")")

        # Color Picker
        (m "SHIFT + C" "hl.dsp.exec_cmd(\"hyprpicker -a\")")

        # ------------------------- #
        # ---- Core Binds --------- #
        # ------------------------- #
        (m "SPACE" "hl.dsp.exec_cmd(\"pkill rofi || ${pkgs.rofi}/bin/rofi -show drun -show-icons\")")
        (m "S" "hl.dsp.exec_cmd(\"noctalia msg panel-toggle control-center\")")

        # Media keys
        (k "XF86AudioRaiseVolume" "hl.dsp.exec_cmd(\"noctalia msg volume-up\")")
        (k "XF86AudioLowerVolume" "hl.dsp.exec_cmd(\"noctalia msg volume-down\")")
        (k "XF86AudioMute" "hl.dsp.exec_cmd(\"noctalia msg volume-mute\")")

        # Brightness
        (k "XF86MonBrightnessUp" "hl.dsp.exec_cmd(\"noctalia msg brightness-up\")")
        (k "XF86MonBrightnessDown" "hl.dsp.exec_cmd(\"noctalia msg brightness-down\")")
      ];
    };
  };
}
