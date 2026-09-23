{
  settings,
  pkgs,
  lib,
  ...
}:
{
  on = {
    _args = [
      "hyprland.start"
      (lib.generators.mkLuaInline ''
        function()
          hl.exec_cmd("warp-cli connect")
          hl.exec_cmd("noctalia --daemon")
          hl.exec_cmd("qs -c overview & disown")
          hl.exec_cmd("${pkgs.wl-clipboard-rs}/bin/wl-paste --type text --watch ${pkgs.cliphist}/bin/cliphist store & disown")
          hl.exec_cmd("${pkgs.wl-clipboard-rs}/bin/wl-paste --type image --watch ${pkgs.cliphist}/bin/cliphist store & disown")
          hl.exec_cmd("${pkgs.hyprland}/bin/hyprctl setcursor ${settings.common.cursor.name} ${toString settings.common.cursor.size} & disown")
          hl.exec_cmd("${pkgs.telegram-desktop}/bin/Telegram -startintray & disown")
        end
      '')
    ];
  };
}
