{ settings, ... }:
{
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland = {
      settings.config = {
        render = {
          direct_scanout = 0;
          cm_auto_hdr = 0;
          cm_enabled = true;
          cm_sdr_eotf = "gamma22";
          new_render_scheduling = true;
          use_fp16 = 2;
        };
      };
    };
  };
}
