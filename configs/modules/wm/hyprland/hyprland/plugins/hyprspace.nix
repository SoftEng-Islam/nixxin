{ settings, lib, pkgs, ... }:
let
  hyprspace = (pkgs.hyprlandPlugins.hyprspace.override {
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
        hyprspace
      ];
      settings = {
        plugin = {
          overview = {
            autoDrag = false;
            overrideGaps = false;
          };
        };
        bind = [
          # ---- Hyprspace ---- #
          "$main,TAB, overview:toggle" # Overview
        ];
      };
    };
  };
}
