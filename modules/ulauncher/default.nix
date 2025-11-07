# modules/ulauncher/default.nix
# ==============================================================================
# Ulauncher Application Launcher Configuration
# ==============================================================================
{ settings, config, lib, pkgs, ... }:
let ulauncher_config = ./config;
in {
  config = lib.optionals (settings.modules.ulauncher.enable) {
    environment.systemPackages = with pkgs; [ ulauncher ];
    home-manager.users.${settings.user.username} = {
      # =============================================================================
      # Service Configuration
      # =============================================================================
      systemd.user.services.ulauncher = {
        Unit = {
          Description = "ulauncher application launcher service";
          Documentation = "https://ulauncher.io";
          After = [ "graphical-session-pre.target" ];
          PartOf = [ "graphical-session.target" ];
        };
        Service = {
          Type = "simple";
          ExecStart =
            "${pkgs.bash}/bin/bash -lc '${pkgs.ulauncher}/bin/ulauncher --hide-window'";
          Restart = "always";
          RestartSec = 2;
        };
        Install = { WantedBy = [ "graphical-session.target" ]; };
      };

      # =============================================================================
      # Configuration Files
      # =============================================================================
      xdg.configFile = {
        "ulauncher" = {
          recursive = true;
          source = "${ulauncher_config}";
        };
      };
    };
  };
}
