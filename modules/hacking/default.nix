{
  settings,
  lib,
  pkgs,
  pkgs-older,
  ...
}:
let
  inherit (lib) mkIf;
in
{
  config = mkIf (settings.modules.hacking.enable) {
    environment.systemPackages =
      with pkgs;
      [
        hashcat
        hashcat-utils
        john
        johnny
        aircrack-ng
        wireshark
        airgorah
        xterm
        macchanger
        hcxdumptool
        hcxtools
        netcat
        netop
        cowpatty
        wavemon
        linssid
        wifite2
        thc-hydra
        vault-medusa
        medusa
      ]
      ++ lib.optional (hashcatLegacy != null) hashcatLegacy;
  };
}
