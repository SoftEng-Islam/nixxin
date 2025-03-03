{ settings, config, lib, pkgs, ... }:
let inherit (lib) mkIf;
in {
  config = lib.optionals (settings.modules.ulauncher.enable) {
    environment.systemPackages = with pkgs; [ ulauncher ];
    # Ulauncher service configuration
    systemd.services.ulauncher = {
      # WantedBy=graphical-session.target
      wantedBy = [ "graphical-session.target" ];
      description = "Start the ulauncher";
      unitConfig = { Documentation = "https://ulauncher.io"; };
      serviceConfig = {
        # BusName=io.ulauncher.Ulauncher
        # Type=dbus
        Type = "simple";
        BusName = "io.ulauncher.Ulauncher";
        # Restart=always
        Restart = "always";
        # RestartSec=1;
        RestartSec = 1;
        # ExecStart=/usr/bin/ulauncher --hide-window
        ExecStart = "${pkgs.ulauncher}/bin/ulauncher --hide-window";
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
