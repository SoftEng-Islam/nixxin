{ settings, pkgs, ... }: {
  environment.systemPackages = with pkgs;
    [
      # inputs.hyprpolkitagent.packages."${system}".hyprpolkitagent
      hyprpolkitagent
    ];
  home-manager.users."${settings.users.selected.username}" = {
    systemd.user.services.hyprpolkitagent = {
      Unit.Description = "Hyprpolkitagent - Polkit authentication agent";
      Install.WantedBy = [ "graphical-session.target" ];

      Service = {
        ExecStart = "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent";
        Nice = "-20";
        Restart = "on-failure";
        StartLimitIntervalSec = 60;
        StartLimitBurst = 60;
      };
      # start polkit to support authentication prompts
      # wayland.windowManager.hyprland.settings.exec-once =
      #   [ "systemctl --user start hyprpolkitagent" ];
    };
  };
}
