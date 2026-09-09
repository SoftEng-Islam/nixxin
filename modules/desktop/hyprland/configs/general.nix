{ settings, ... }:
{
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland = {
      settings = {
        general = {
          # This just allows the `immediate` window rule to work
          allow_tearing = true;

          layout = "dwindle";

          no_focus_fallback = true;

          # ╔═══════════════════════════════════════════════════════════════╗
          # ║                    Gap Configuration                          ║
          # ║  Slightly reduced for better visual space on APU              ║
          # ╚═══════════════════════════════════════════════════════════════╝
          gaps_in = 12; # Reduced from 15 (inner gaps)
          gaps_out = 24; # Reduced from 30 (outer gaps)
          gaps_workspaces = 12; # Reduced from 15 (workspace gaps)

          # ╔═══════════════════════════════════════════════════════════════╗
          # ║                    Border Configuration                       ║
          # ╚═══════════════════════════════════════════════════════════════╝
          border_size = settings.modules.desktop.hyprland.border.size;
          resize_on_border = true;
          hover_icon_on_border = true;
          extend_border_grab_area = 15;
          "col.inactive_border" = settings.modules.desktop.hyprland.border.inactive.color;
          "col.active_border" = "$primary";

          snap = {
            enabled = true;
            border_overlap = false;
            respect_gaps = true;
            monitor_gap = 10;
            window_gap = 10;
          };
        };
      };
    };
  };
}
