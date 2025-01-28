{ settings, lib, pkgs, ... }:
let
  Hyprspace = (pkgs.hyprlandPlugins.hyprspace.override {
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
    wayland.windowManager.hyprland = {
      plugins = [
        # inputs.Hyprspace.packages.${pkgs.system}.Hyprspace
        pkgs.hyprlandPlugins.hyprspace
      ];
      extraConfig = ''
        # plugin = ${pkgs.hyprlandPlugins.hyprspace}/lib/libhyprspace.so
        plugin {
          overview {
            autoDrag = false
            overrideGaps = false
            gapsIn = 5
            gapsOut = 5
            panelHeight = 100
            showEmptyWorkspace = false
            showNewWorkspace = false
            workspaceActiveBorder = rgba(15803D99)
          }
        }
        bind = $main, TAB, overview:toggle
        bind = $main SHIFT, TAB, overview:toggle, all
      '';
    };
  };
}
