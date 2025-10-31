{ settings, ... }: {
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland = {
      settings.decoration = {
        rounding = settings.modules.desktop.hyprland.rounding;

        # ---- Blur ---- #
        blur = {
          enabled = settings.modules.desktop.hyprland.blur.enable;
          xray = true;
          ignore_opacity = true;
          special = true;
          new_optimizations = true;
          passes = 4;
          brightness = 1;
          noise = 1.0e-2;
          contrast = 1;
          popups = true;
          popups_ignorealpha = 0.6;
        };

        # ---- Shadow ---- #
        shadow = {
          enabled = settings.modules.desktop.hyprland.shadow.enable;
          range = 15;
          offset = "0 2";
          render_power = 2;
          ignore_window = true;
          color = "rgba(00000070)";
          # col.shadow = rgba(00000070)
          # col.shadow_inactive = rgba(00000020)
          # "col.shadow" = "rgba(${config.lib.stylix.colors.base00}ff)";
        };

        # ---- Dim ---- #
        dim_inactive = settings.modules.desktop.hyprland.dim_inactive;
        dim_strength = 0.2;
        dim_special = 0;
      };
    };
  };
}
