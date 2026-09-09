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
         
              hl.exec_cmd("noctalia --daemon")
              hl.exec_cmd("qs -c overview & disown")
             
              hl.exec_cmd("${pkgs.hyprshade}/bin/hyprshade toggle ~/.config/hypr/shaders/blue-light-filter.glsl & disown")
              
              hl.exec_cmd("${pkgs.wl-clipboard-rs}/bin/wl-paste --type text --watch ${pkgs.cliphist}/bin/cliphist store & disown")
              hl.exec_cmd("${pkgs.wl-clipboard-rs}/bin/wl-paste --type image --watch ${pkgs.cliphist}/bin/cliphist store & disown")
             
              hl.exec_cmd("${pkgs.hyprland}/bin/hyprctl setcursor ${settings.common.cursor.name} ${toString settings.common.cursor.size} & disown")

              
              hl.exec_cmd("${pkgs.telegram-desktop}/bin/telegram-desktop -startintray & disown")
            end
          '')
        ];
      };
    };
  };
}
