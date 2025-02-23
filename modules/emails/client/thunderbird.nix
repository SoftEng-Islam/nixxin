# https://www.thunderbird.net/en-US/
{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in { environment.systemPackages = with pkgs; [ thunderbird-latest ]; }
