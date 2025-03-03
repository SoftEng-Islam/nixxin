{ settings, config, lib, pkgs, ... }:
let inherit (lib) mkIf;
in {
  config = lib.optionals (settings.modules.ulauncher.enable) {
    environment.systemPackages = with pkgs; [ ulauncher ];
    # Ulauncher service configuration
    systemd.services.ulauncher = {
      # Description = "Ulauncher application launcher service";
      # After = [ "graphical-session.target" ];
      # WantedBy = [ "default.target" ];
      Service = {
        ExecStart = "${pkgs.ulauncher}/bin/ulauncher --hide-window";
        Restart = "on-failure"; # Restart only on failure
      };

    };
    home-manager.users.${settings.user.username} = {
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
