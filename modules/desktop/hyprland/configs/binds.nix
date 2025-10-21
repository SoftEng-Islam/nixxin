{ settings, ... }: {
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland = {
      settings.binds = {
        # This allows cycling through workspaces when reaching the last one.
        allow_workspace_cycles = true;

        # in ms, how many ms to wait after a scroll event to allow passing another one for the binds.
        # scroll_event_delay = 0; # in milliseconds

        # If enabled, an attempt to switch to the currently focused workspace will instead switch to the previous workspace. Akin to i3’s auto_back_and_forth.
        workspace_back_and_forth = false;

        # if disabled, will not pass the mouse events to apps / dragging windows around if a keybind has been triggered.
        pass_mouse_when_bound = false;

        # movefocus_cycles_fullscreen = true;
      };
    };
  };
}
