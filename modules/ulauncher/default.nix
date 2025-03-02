{ settings, config, lib, pkgs, ... }:
let inherit (lib) mkIf;
in {
  config = lib.optionals (settings.modules.ulauncher.enable) {
    environment.systemPackages = with pkgs; [ ulauncher ];
    home-manager.users.${settings.user.username} = {
      systemd.user.services.ulauncher = {
        Unit = {
          Description = "Ulauncher";
          After = [ "graphical-session.target" ];
        };

        Service = {
          ExecStart = "${pkgs.ulauncher}/bin/ulauncher --hide-window";
          Restart = "always";
        };

        Install = { WantedBy = [ "default.target" ]; };
      };
    };
  };
}
