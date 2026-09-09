{
  settings,
  pkgs,
  lib,
  ...
}:
{
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland.settings = {
      on = {
        _args = [
          "hyprland.start"
          (lib.generators.mkLuaInline ''
            function()
              # ---- Start Noctalia V5 Shell ---- #
              hl.exec_cmd("noctalia --daemon")
              hl.exec_cmd("qs -c overview & disown")
              # ---- Blue Color Filter ---- #
              hl.exec_cmd("${pkgs.hyprshade}/bin/hyprshade toggle ~/.config/hypr/shaders/blue-light-filter.glsl & disown")
              # ---- Clipboard ---- #
              hl.exec_cmd("${pkgs.wl-clipboard-rs}/bin/wl-paste --type text --watch ${pkgs.cliphist}/bin/cliphist store & disown")
              hl.exec_cmd("${pkgs.wl-clipboard-rs}/bin/wl-paste --type image --watch ${pkgs.cliphist}/bin/cliphist store & disown")
              # ---- Set Cursor ---- #
              hl.exec_cmd("${pkgs.hyprland}/bin/hyprctl setcursor ${settings.common.cursor.name} ${toString settings.common.cursor.size} & disown")

              # ---- Apps To Start ---- #
              hl.exec_cmd("${pkgs.telegram}/bin/telegram -startintray & disown")
            end
          '')
        ];
      };
    };
  };
}
