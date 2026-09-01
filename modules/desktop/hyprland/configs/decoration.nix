{ settings, ... }:
{
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland = {
      settings.decoration = {
        rounding = settings.modules.desktop.hyprland.rounding;

        # ╔════════════════════════════════════════╗
        # ║            Blur Settings               ║
        # ║  Optimized for AMD APU Performance     ║
        # ╚════════════════════════════════════════╝
        blur = {
          enabled = settings.modules.desktop.hyprland.blur.enable;

          # Xray mode: only blur transparent parts of windows
          xray = true;

          # Blur windows with opacity set (improves performance)
          ignore_opacity = true;

          # Blur special workspaces
          special = true;

          # REMOVED: new_optimizations is deprecated/removed in recent Hyprland
          # Modern blur optimizations are now always enabled

          # Blur popups (e.g., context menus)
          popups = true;
          popups_ignorealpha = 0.6;

          # Blur settings: Lower values = better performance on APU
          # For Ryzen 3400G APU, keep size low and passes at 1 for best performance
          size = 3;        # Blur radius - keep low for APU
          passes = 1;      # Single pass recommended for APU

          # Visual adjustments
          brightness = 0.5;
          noise = 0.0;
          contrast = 0.5;
        };

        # ╔════════════════════════════════════════╗
        # ║           Shadow Settings              ║
        # ║  Optimized for APU Performance         ║
        # ╚════════════════════════════════════════╝
        shadow = {
          enabled = settings.modules.desktop.hyprland.shadow.enable;

          # Reduced range for better performance (default: 20)
          range = 12;

          # Subtle offset for natural look
          offset = "0 2";

          # Lower render power = better performance (default: 3)
          render_power = 2;

          # Shadow color with transparency
          color = "rgba(00000070)";
        };

        # ---- Dim ---- #
        dim_inactive = settings.modules.desktop.hyprland.dim_inactive;
        dim_strength = 0.2;
        dim_special = 0;
      };
    };
  };
}
