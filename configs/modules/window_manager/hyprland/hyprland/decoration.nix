{ settings, ... }: {
  home-manager.users.${settings.users.user1.username} = {
    wayland.windowManager.hyprland = {
      settings.decoration = {
        rounding = settings.rounding;

        # ---- Blur ---- #
        blur = {
          enabled = settings.blur;
          xray = true;
          ignore_opacity = true;
          special = true;
          new_optimizations = true;
          size = 6;
          passes = 2;
          brightness = 1;
          noise = 1.0e-2;
          contrast = 1;
          popups = true;
          popups_ignorealpha = 0.6;
        };

        # ---- Shadow ---- #
        shadow = {
          enabled = settings.shadow;
          range = 20;
          offset = "0 2";
          render_power = 2;
          ignore_window = true;
          # col.shadow = rgba(00000070)
          # col.shadow_inactive = rgba(00000020)
          # "col.shadow" = "rgba(${config.lib.stylix.colors.base00}ff)";
        };

        # ---- Dim ---- #
        dim_inactive = settings.dim_inactive;
        dim_strength = 0.2;
        dim_special = 0;
      };
    };
  };
}
