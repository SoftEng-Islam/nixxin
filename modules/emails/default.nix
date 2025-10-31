# https://www.thunderbird.net/en-US/
{ settings, config, lib, pkgs, ... }:
let inherit (lib) mkIf;
in {
  config = mkIf (settings.modules.emails.enable or true) {
    home-manager.users.${settings.user.username} = {
      programs.thunderbird = {
        enable = true;
        # nativeMessagingHosts = [];
        package = pkgs.thunderbird-latest;
        profiles = {
          "main" = {
            isDefault = true;
            settings = {
              "calendar.alarms.showmissed" = false;
              "calendar.alarms.playsound" = false;
              "calendar.alarms.show" = false;
            };
          };
        };
      };
    };

    services = {
      orca.enable = false; # requires speechd
      speechd.enable = false; # voice files are big and fat
    };
    environment.systemPackages = with pkgs; [ thunderbird-latest ];
  };
}
