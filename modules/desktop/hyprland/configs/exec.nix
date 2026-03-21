{
  settings,
  inputs,
  pkgs,
  ...
}:
let
  fontName = "${settings.modules.fonts.main.name} ${toString settings.modules.fonts.main.size.main}";
  system = pkgs.stdenv.hostPlatform.system;
  hyprpolkitagentPkg =
    inputs.hyprpolkitagent.packages.${system}.hyprpolkitagent
      or inputs.hyprpolkitagent.packages.${system}.default or pkgs.update.hyprpolkitagent
        or pkgs.hyprpolkitagent;
  hyprpolkitagentExe = "${hyprpolkitagentPkg}/bin/hyprpolkitagent";
  hyprpolkitagentLibexecExe = "${hyprpolkitagentPkg}/libexec/hyprpolkitagent";
  startupScript = pkgs.writeShellScriptBin "start" ''
    #!/usr/bin/env bash
    # ---- DBUS ---- #
    systemctl --user import-environment \
      WAYLAND_DISPLAY DISPLAY \
      XDG_CURRENT_DESKTOP XDG_SESSION_DESKTOP XDG_SESSION_TYPE \
      XDG_DATA_DIRS XDG_RUNTIME_DIR \
      PATH
    dbus-update-activation-environment --systemd \
      WAYLAND_DISPLAY DISPLAY \
      XDG_CURRENT_DESKTOP XDG_SESSION_DESKTOP XDG_SESSION_TYPE \
      XDG_DATA_DIRS XDG_RUNTIME_DIR \
      PATH
    ${pkgs.hyprshade}/bin/hyprshade toggle ~/.config/hypr/shaders/blue-light-filter.glsl & disown

    # Core components (authentication, lock screen, notification daemon)
    ${pkgs.gnome-keyring}/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh & disown
    if [ -x "${hyprpolkitagentExe}" ]; then
      ${pkgs.procps}/bin/pgrep -x hyprpolkitagent >/dev/null 2>&1 || QT_QPA_PLATFORM=wayland "${hyprpolkitagentExe}" & disown
    elif [ -x "${hyprpolkitagentLibexecExe}" ]; then
      ${pkgs.procps}/bin/pgrep -x hyprpolkitagent >/dev/null 2>&1 || QT_QPA_PLATFORM=wayland "${hyprpolkitagentLibexecExe}" & disown
    fi

    # ---- Clipboard ---- #
    ${pkgs.wl-clipboard-rs}/bin/wl-paste --type text --watch ${pkgs.cliphist}/bin/cliphist store  & disown
    ${pkgs.wl-clipboard-rs}/bin/wl-paste --type image --watch ${pkgs.cliphist}/bin/cliphist store & disown

    # ---- Set Cursor ---- #
    hyprctl setcursor ${settings.common.cursor.name} ${toString settings.common.cursor.size} & disown

    # ---- Set Desktop Wallpaper ---- #
    # changeWallpaper & disown
    # sleep 1

    # ---- Notification daemon ---- #
    # swaync & disown
    # sleep 1

    # ---- Apps To Start ---- #
    # Telegram -startintray & disown

    # Auto-start the overview of QuickShell
    qs -c overview & disown
  '';
in
{
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland.settings = {
      exec-once = "${startupScript}/bin/start";
    };
  };
}
