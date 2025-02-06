{ settings, ... }: {
  home-manager.users.${settings.users.selected.username} = {
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
          gaps_workspaces = 50;
          border_size = 6;
          resize_on_border = true;
          "col.inactive_border" = "$surface";
          "col.active_border" = "$primary";

          # => Active Borders with `static` color, uncomment only one:
          # "col.active_border" = "rgba(3584E4ff)"; # Blue
          # "col.active_border" = "rgba(2190A4ff)"; # Teal
          # "col.active_border" = "rgba(3A944Aff)"; # Green
          # "col.active_border" = "rgba(C88800ff)"; # Yellow
          # "col.active_border" = "rgba(ED5B00ff)"; # Ornage
          # "col.active_border" = "rgba(E62D42ff)"; # Red
          # "col.active_border" = "rgba(D56199ff)"; # Pink
          # "col.active_border" = "rgba(9141ACff)"; # Purple
          # "col.active_border" = "rgba(6F8396ff)"; # Slate

          # => Active Border with `graid` colors:
          # "col.active_border"="rgba(673ab7ff) rgba(E62D42ff) 45deg";

          # => Active/Inactive border colors with `stylix`:
          # "col.active_border" = "rgba(${config.lib.stylix.colors.base0D}ff)";
          # "col.inactive_border" = "rgba(${config.lib.stylix.colors.base02}ff)";
        };
      };
    };
  };
}
