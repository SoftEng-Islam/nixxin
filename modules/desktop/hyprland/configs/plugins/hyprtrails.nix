{ settings, pkgs, ... }:
let
  hyprtrails = (pkgs.hyprlandPlugins.hyprtrails.override {
    # Make sure it's using the same hyprland package as we are
    hyprland = pkgs.hyprland;
  });
in {
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland.plugins = [
      # inputs.hyprland-plugins.packages.${pkgs.system}.hyprtrails
      hyprtrails
    ];
    wayland.windowManager.hyprland.extraConfig = ''
      plugin:hyprtrails {
        color = rgba(ffaa00ff)
      }
    '';
  };
}
