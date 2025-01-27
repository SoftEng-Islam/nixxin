{ settings, config, inputs, pkgs, ... }: {
  home-manager.users.${settings.username} = {
    wayland.windowManager.hyprland.plugins = [
      # pkgs.hyprlandPlugins.hyprtrails
      # inputs.hyprland-plugins.packages.${pkgs.system}.hyprtrails
      (pkgs.hyprlandPlugins.hyprtrails.override {
        # Make sure it's using the same hyprland package as we are
        hyprland = config.wayland.windowManager.hyprland.package;
      })
    ];
    wayland.windowManager.hyprland.extraConfig = ''
      plugin:hyprtrails {
        color = rgba(ffaa00ff)
      }
    '';
  };
}
