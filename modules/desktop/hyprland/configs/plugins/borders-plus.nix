{ settings, lib, pkgs, ... }:
let
  borders-plus-plus = (pkgs.hyprlandPlugins.borders-plus-plus.override {
    # Make sure it's using the same hyprland package as we are
    hyprland = pkgs.hyprland;
  }).overrideAttrs (old: {
    # Yeet the initialization notification (I hate it)
    postPatch = (old.postPatch or "") + ''
      ${lib.getExe pkgs.gnused} -i '/Initialized successfully/d' main.cpp
    '';
  });
in {
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland.plugins = [
      # inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.borders-plus-plus
      borders-plus-plus
    ];
    wayland.windowManager.hyprland.extraConfig = ''
      plugin:borders-plus-plus {
        add_borders = 1 # 0 - 9

        # You can add up to 9 borders
        col.border_1 = rgba(00000060)

        # -1 means "default" as in the one defined in general:border_size
        border_size_1 = 4

        # makes outer edges match rounding of the parent. turn on/off to better understand. default = on.
        natural_rounding = yes
      }
    '';
  };
}
