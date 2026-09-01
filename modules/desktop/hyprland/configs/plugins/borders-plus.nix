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
      # ╔═══════════════════════════════════════╗
      # ║       Borders Plus Plus Plugin        ║
      # ║      Additional Border Layers         ║
      # ╚═══════════════════════════════════════╝

      plugin {
        borders-plus-plus {
          # Number of additional borders (0-9)
          add_borders = 1

          # Border 1: Subtle shadow effect
          col.border_1 = rgba(00000060)

          # Border size (-1 = use default from general:border_size)
          border_size_1 = 4

          # Natural rounding: outer edges match parent window rounding
          natural_rounding = yes
        }
      }
    '';
  };
}
