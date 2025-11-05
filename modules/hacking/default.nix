{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in {
  # imports = lib.optionals (settings.modules.hacking.enable) [ ./hashcat.nix ];
  config = mkIf (settings.modules.hacking.enable) {
    environment.variables = {
      ROC_ENABLE_PRE_VEGA = "1";
      # iris, llvmpipe, nouveau, panfrost, radeonsi,
      # RUSTICL_ENABLE = "radeonsi";
    };
    environment.systemPackages = with pkgs; [
      # hashcat.overrideAttrs
      # (old: {
      #   preFixup = (old.preFixup or "") + ''
      #     for f in $(find $out/share/hashcat/OpenCL -name '*.cl'); do
      #       sed "s|#include \"\(.*\)\"|#include \"$out/share/hashcat/OpenCL/\1\"|g" -i "$f"
      #     done
      #   '';
      # })
      hashcat # Fast password cracker
      hashcat-utils # Small utilities that are useful in advanced password cracking

      # John the Ripper password cracker
      john

      # Open Source GUI frontend for John the Ripper
      johnny

      # WiFi security auditing tools suite
      aircrack-ng

      # Powerful network protocol analyzer
      wireshark

      # WiFi security auditing software mainly based on aircrack-ng tools suite
      airgorah

      xterm

      # Utility for viewing/manipulating the MAC address of network interfaces
      macchanger

      # Small tool to capture packets from wlan devices
      hcxdumptool

      # Tools for capturing wlan traffic and conversion to hashcat and John the Ripper formats
      hcxtools

      # Free TLS/SSL implementation
      netcat

      # Network monitor using bpf
      netop

      # Simple tool for transporting data over the network
      #netrw

      # Set of tools for controlling the network subsystem in Linux
      nettools

      # Offline dictionary attack against WPA/WPA2 networks
      cowpatty

      # Ncurses-based monitoring application for wireless network devices
      wavemon

      # Graphical wireless scanning for Linux
      linssid

      # Rewrite of the popular wireless network auditor, wifite
      wifite2

      # https://github.com/vanhauser-thc/thc-hydra/
      # Very fast network logon cracker which support many different services
      thc-hydra

      # Cli tool for importing and exporting Hashicorp Vault secrets
      vault-medusa

      # Speedy, parallel, and modular, login brute-forcer
      medusa
    ];
  };
}
