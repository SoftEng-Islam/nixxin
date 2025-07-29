{ settings, config, lib, pkgs, ... }:
let inherit (lib) mkIf;
in {
  config = lib.optionals (settings.modules.ulauncher.enable) {
    environment.systemPackages = with pkgs; [ ulauncher ];
    home-manager.users.${settings.user.username} = {
      # Ulauncher service configuration
      systemd.user.services.ulauncher = {
        Unit = {
          Description = "ulauncher application launcher service";
          Documentation = "https://ulauncher.io";
          PartOf = [ "graphical-session.target" ];
        };

        Service = {
          Type = "simple";
          ExecStart =
            "${pkgs.bash}/bin/bash -lc '${pkgs.ulauncher}/bin/ulauncher --hide-window'";
          Restart = "always";
        };

        Install.WantedBy = [ "graphical-session.target" ];
      };

      # Source ulauncher configuration from this repository
      xdg.configFile = {
        "ulauncher" = {
          recursive = true;
          source = ./config;
        };
      };
    };
  };
}
