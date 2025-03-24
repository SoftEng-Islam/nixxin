# https://www.thunderbird.net/en-US/
{ settings, config, lib, pkgs, ... }:
let inherit (lib) mkIf;
in {
  config = mkIf (settings.modules.emails.enable or true) {

    home-manager.users.${settings.user.username} = {
      programs.thunderbird = {
        enable = true;
        # programs.thunderbird.nativeMessagingHosts = [];
        programs.thunderbird.package = pkgs.thunderbird-latest;

      };
    };

    environment.systemPackages = with pkgs; [ thunderbird-latest birdtray ];
  };
}
