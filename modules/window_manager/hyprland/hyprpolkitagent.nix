{ settings, lib, pkgs, ... }: {
  security.polkit.enable = true;
  security.polkit.package = pkgs.polkit;
  systemd.services.polkit = { serviceConfig.NoNewPrivileges = false; };

  home-manager.users.${settings.user.username} = {
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
    };
  };
  environment.systemPackages = with pkgs; [
    hyprpolkitagent # Polkit authentication agent written in QT/QML
    polkit # Toolkit for defining and handling the policy that allows unprivileged processes to speak to privileged processes
  ];
}
