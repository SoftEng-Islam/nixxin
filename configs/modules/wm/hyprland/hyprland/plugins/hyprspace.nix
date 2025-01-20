{ settings, inputs, pkgs, ... }: {
  home-manager.users.${settings.username} = {
    wayland.windowManager.hyprland = {
      plugins = [ inputs.Hyprspace.packages.${pkgs.system}.Hyprspace ];
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
