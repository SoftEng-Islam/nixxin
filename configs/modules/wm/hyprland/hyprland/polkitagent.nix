{ settings, inputs, pkgs, ... }: {
  home-manager.users.${settings.username} = {
    home.packages =
      [ inputs.hyprpolkitagent.packages."${pkgs.system}".hyprpolkitagent ];

    wayland.windowManager.hyprland.settings.exec-once =
      [ "systemctl --user start hyprpolkitagent" ];
  };
}
