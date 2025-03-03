{ settings, config, lib, pkgs, ... }:
let inherit (lib) mkIf;
in {
  config = lib.optionals (settings.modules.ulauncher.enable) {
    environment.systemPackages = with pkgs; [ ulauncher ];
    home-manager.users.${settings.user.username} = {
      # Ulauncher service configuration
      systemd.user.services.ulauncher = {
        description = "Ulauncher application launcher service";
        after = [ "graphical-session.target" ];
        install = { wantedBy = [ "default.target" ]; };
        serviceConfig = {
          ExecStart = "${pkgs.ulauncher}/bin/ulauncher --hide-window";
          Restart = "on-failure"; # Restart only on failure
        };
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
