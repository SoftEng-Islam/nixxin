{ settings, lib, pkgs, ... }:
let
  hyprtrails = (pkgs.hyprlandPlugins.hyprtrails.override {
    # Make sure it's using the same hyprland package as we are
    hyprland = pkgs.hyprland;
  }).overrideAttrs (old: {
    # Yeet the initialization notification (I hate it)
    postPatch = (old.postPatch or "") + ''
      ${lib.getExe pkgs.gnused} -i '/Initialized successfully/d' main.cpp
    '';
  });
in {
  home-manager.users.${settings.username} = {
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
