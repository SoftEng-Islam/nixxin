{ settings, ... }: {
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland = {
      # render section for Hyprland >= v0.42.0
      settings.render = {
        # Controls explicit synchronization for rendering.
        # `0`: Disabled.
        # `1`: Enabled, but only for clients that explicitly request it.
        # `2`: Always enabled.
        # explicit_sync = 2;

        # helpful on systems with modern GPUs to avoid tearing when interacting with displays.
        # `0` = disable
        # `1` = Enabled only when explicitly required
        # `2` = Always enabled.
        # explicit_sync_kms = 2;

        # Direct scan-out can improve performance and reduce latency by skipping the compositor and allowing the display to render directly. However, it may not always work depending on hardware, drivers, or specific apps. Setting this to false disables it entirely.
        direct_scanout = true; # true or false
      };
    };
  };
}
