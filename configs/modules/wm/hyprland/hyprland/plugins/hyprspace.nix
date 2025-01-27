{ settings, config, lib, inputs, pkgs, ... }: {
  home-manager.users.${settings.username} = {
    wayland.windowManager.hyprland = {
      plugins = [
        # pkgs.hyprlandPlugins.hyprspace
        # inputs.Hyprspace.packages.${pkgs.system}.Hyprspace
        (pkgs.hyprlandPlugins.hyprspace.override {
          # Make sure it's using the same hyprland package as we are
          hyprland = config.wayland.windowManager.hyprland.package;
        }).overrideAttrs
        (old: {
          # Yeet the initialization notification (I hate it)
          postPatch = (old.postPatch or "") + ''
            ${lib.getExe pkgs.gnused} -i '/Initialized successfully/d' main.cpp
          '';
        })
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
