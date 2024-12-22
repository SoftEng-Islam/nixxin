{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    hcxdumptool # Small tool to capture packets from wlan devices
    hcxtools # Tools for capturing wlan traffic and conversion to hashcat and John the Ripper formats
    aircrack-ng # WiFi security auditing tools suite
    netop
    netrw
    netcat
    nettools
  ];
}
