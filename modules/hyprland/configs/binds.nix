{ settings, ... }: {
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland = {
      settings.binds = {
        # This allows cycling through workspaces when reaching the last one.
        allow_workspace_cycles = true;
        scroll_event_delay = 300; # in milliseconds
        workspace_back_and_forth = false;
        pass_mouse_when_bound = false;
      };
    };
  };
}
