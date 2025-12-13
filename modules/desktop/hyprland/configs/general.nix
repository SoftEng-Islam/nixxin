{ settings, ... }: {
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland = {
      settings = {
        dwindle = {
          pseudotile = true;
          smart_split = true;
          preserve_split = true;
          smart_resizing = true;
          force_split = 1; # 0 or 1 or 2
          special_scale_factor = 1; # [0 - 1]
          # no_gaps_when_only = 0;
        };
        master = {
          new_status = "master";
          new_on_top = 1;
          mfact = 0.5;
          smart_resizing = true;
          new_on_active = true;
          drop_at_cursor = true;
        };
        general = {
          layout = "dwindle";

          # This just allows the `immediate` window rule to work
          allow_tearing = true;

          no_focus_fallback = true;
          gaps_in = 5;
          gaps_out = 8;
          gaps_workspaces = 30;
          border_size = settings.modules.desktop.hyprland.border.size;
          resize_on_border = true;
          hover_icon_on_border = true;
          extend_border_grab_area = 10;
          "col.inactive_border" = "$surface";
          "col.active_border" = "$primary";

          snap = { enabled = true; };
        };
        "ecosystem:no_update_news" = true;
        "ecosystem:no_donation_nag" = true;
      };
    };
  };
}
