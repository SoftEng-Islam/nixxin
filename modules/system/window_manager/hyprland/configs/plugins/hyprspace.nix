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
  home-manager.users.${settings.users.selected.username} = {
    wayland.windowManager.hyprland = {
      plugins = [
        # inputs.Hyprspace.packages.${pkgs.system}.Hyprspace
        pkgs.hyprlandPlugins.hyprspace
      ];
      extraConfig = ''
        # plugin = ${pkgs.hyprlandPlugins.hyprspace}/lib/libhyprspace.so
        plugin {
          overview {
            # ---- Colors ---- #
            #panelColor = rgb()
            #panelBorderColor = rgb()
            workspaceActiveBorder = $primary
            #workspaceInactiveBorder =
            #workspaceActiveBackground =
            #workspaceInactiveBackground
            dragAlpha = 1
            disableBlur = 0
            # ---- Layout ---- #
            panelHeight = 100
            panelBorderWidth = 2
            onBottom = 1
            reservedArea = 0
            workspaceBorderSize = 2
            centerAligned = 1
            hideBackgroundLayers = 1
            hideTopLayers = 1
            hideOverlayLayers = 1
            hideRealLayers = 1
            drawActiveWorkspace = 1
            overrideGaps = 1
            gapsIn = 5
            gapsOut = 5
            affectStrut = 1
            # ---- Animation ---- #
            # overrideAnimSpeed =
            # ---- Behaviors ---- #
            autoDrag = 1
            autoScroll = 1
            exitOnClick = 1
            switchOnDrop = 0
            exitOnSwitch = 0
            showEmptyWorkspace = 1
            showSpecialWorkspace = 0
            reverseSwipe = 0
            showNewWorkspace = 1
            disableGestures = 1
            # gestures:workspace_swipe_fingers
            # gestures:workspace_swipe_cancel_ratio
            # gestures:workspace_swipe_min_speed_to_force
          }
        }
        bind = $main, TAB, overview:toggle
        bind = $main SHIFT, TAB, overview:toggle, all
      '';
    };
  };
}
