# https://www.thunderbird.net/en-US/
{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.emails.client.thunderbird) {
  environment.systemPackages = with pkgs; [ thunderbird-latest birdtray ];
}
