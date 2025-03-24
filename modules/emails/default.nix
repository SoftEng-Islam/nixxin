# https://www.thunderbird.net/en-US/
{ settings, config, lib, pkgs, ... }:
let inherit (lib) mkIf;
in {
  config = mkIf (settings.modules.emails.enable or true) {
    environment.systemPackages = with pkgs; [ thunderbird-latest birdtray ];
  };
}
