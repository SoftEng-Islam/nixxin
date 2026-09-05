{ settings, ... }: {
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland = {
      # render section for Hyprland >= v0.42.0
      settings.render = {
        # ╔════════════════════════════════════════════════════════════════╗
        # ║  DEPRECATED: explicit_sync settings removed in Hyprland 0.50+  ║
        # ║  Explicit sync is now always enabled by default                ║
        # ╚════════════════════════════════════════════════════════════════╝

        # Direct scan-out improves performance and reduces latency by skipping
        # the compositor. Works well with AMD GPUs.
        direct_scanout = false;
      };
    };
  };
}
