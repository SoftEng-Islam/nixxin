{ settings, pkgs, ... }: {
  environment.systemPackages = with pkgs;
    [
      # inputs.hyprpolkitagent.packages."${system}".hyprpolkitagent
      hyprpolkitagent
      # polkit
      # polkit_gnome
    ];
  home-manager.users."${settings.user.username}" = {
    # systemd.user.services.hyprpolkitagent = {
    #   Unit.Description = "Hyprpolkitagent - Polkit authentication agent";
    #   Install.WantedBy = [ "graphical-session.target" ];

    #   Service = {
    #     ExecStart = "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent";
    #     Nice = "-20";
    #     Restart = "on-failure";
    #     StartLimitIntervalSec = 60;
    #     StartLimitBurst = 60;
    #   };
    # };
  };
}
