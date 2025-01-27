{ settings, inputs, pkgs, ... }: {
  home-manager.users.${settings.username} = {
    wayland.windowManager.hyprland.plugins = [
      # pkgs.hyprlandPlugins.hyprtrails
      inputs.hyprland-plugins.packages.${pkgs.system}.hyprtrails
    ];
    wayland.windowManager.hyprland.extraConfig = ''
      plugin:hyprtrails {
        color = rgba(ffaa00ff)
      }
    '';
  };
}
